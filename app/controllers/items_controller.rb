class ItemsController < ApplicationController
  before_action :header_menu,only: [:index,:show,:search]
  before_action :set_item,only: [:show,:update,:edit]
  before_action :set_js_params,only: [:new,:edit]
  before_action :move_to_index,only: [:new,:edit]
  before_action :search_params, only: :search_detail
  add_breadcrumb 'メルカリ', :root_path, except: [:index]

  def index
    @pick_up_categories = Category.where(pick_up:1)
    @pick_up_brands = Brand.where(pick_up:1)
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
      if params[:image] && @item.save
        params[:image].each do |image|
          @item.item_images.create(image: image)
      end
        redirect_to root_path
      else
        render 'new'
      end
  end

  def show
    add_breadcrumb @item.name, "items/#{@item.id}"
    @images = @item.item_images
    @comment = ItemComment.new
    @comments = @item.item_comments
    # 下部に表示する出品物の呼び出し（売却済アイテムと、現在詳細表示しているアイテムを除く）
    sold_item = Deal.pluck('item_id')
    @vendor_items = Item.where.not(id:sold_item.push(params[:id])).where(vendor_id:@item.vendor_id).order(id: :DESC).limit(6)
    @brand_items = Item.where.not(id:sold_item.push(params[:id])).where(brand:@item.brand).order(id: :DESC).limit(6)
  end

  def image
  end

  def search
    @items = Item.where('name LIKE(?)',"%#{params[:keyword]}%")
    @query = Item.ransack(params[:q])
  end

  def search_detail
    if search_params
      @q = Item.search(search_params)
      @items = @q.result(distinct: true)
      render templete: 'search'
    else
      @q = Item.ransack(params[:q])
      @items = @q.result(distinct: true)
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.vendor_id == current_user.id
    redirect_to users_path
  end

  def edit
    @item.item_images.build
    @category = @item.category
    @large = Category.roots
    @middle = @category.parent
    @small = @category.root
    gon.image = @item.item_images
  end

  def update
    if @item.vendor_id == current_user.id
      @item.update(edit_item_params)
      if params[:image]
         params[:image].each do |image|
           @item.item_images.create(image: image)
         end
      end
      redirect_to item_path
    end
  end

  private

  def search_params
    params.require(:q).permit!
  end

  def item_params
    params.require(:item).permit(:name,:description,:price,:condition,:shipping_fee,:shipping_date,:shipping_method,:prefecture_id,:size_id,:category_id,:brand,item_images_attributes: [:image]).merge(vendor_id: current_user.id)
  end

  def edit_item_params
    params.require(:item).permit(:name,:description,:price,:condition,:shipping_fee,:shipping_date,:shipping_method,:prefecture_id,:size_id,:category_id,:brand)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_js_params
    gon.middle = Category.where(id:[15..153])
    gon.small  = Category.where(id:[154..1212])
    gon.size = Size.all
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
