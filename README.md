# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false,unique: true|
|tellphone|integer|null: false,unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_phonetic|string|null: false|
|first_name_phonetic|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|icon|string|
|profile|text|
|invitation_code|string|
### Association
- has_one :street_address,dependent: :destroy
- has_one :credit_card,dependent: :destroy
- has_one :vendor, dependent: :destroy
- has_many :social_profiles, dependent: :destroy
- has_many :items
- has_many :item_comments, dependent: :destroy
- has_many :informations
- has_many :do_lists
- has_many :valuations
- has_many :likes
- has_many :points, dependent: :destroy
- has_many :deals

## street_addresses
|Column|Type|Options|
|------|----|-------|
|post_number|integer|
|prefecture_id|references|foreign_key: true|
|city|string|
|address|string|
|building_name|string|
|user_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :prefecture

## prefectures
|Column|Type|Options|
|------|----|-------|
|prefecture|string|
### Association
- has_one :street_address
- has_one :item
- has_one :vendor

## credit_cards
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|month|integer|null: false|
|year|integer|null: false|
|security_code|integer|null: false|
|user_id|references|foreign_key: true|
### Association
- belongs_to :user

## social_profiles
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|provider|string|null: false|
|uid|string|null: false|
|access_token|string|
|access_secret|string|
|name|string|
|email|string|
|image_url|string|
### Association
- belongs_to :user

## informations
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|info|text|null: false|
|user_id|references|foreign_key: true|
### Association
- belongs_to :user

## do_lists
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## points
|Column|Type|Options|
|------|----|-------|
|point|integer|null: false|
|reason|string|null: false|
|user_id|references|foreign_key: true|
|vendor_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :vendor

## items
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|price|integer|null: false|
|condition|string|null: false|
|shipping_method|string|null: false|
|shipping_date|string|null: false|
|shipping_fee|string|null: false|
|category_id|references|foreign_key: true|
|size_id|references|foreign_key: true|
|prefecture_id|references|foreign_key: true|
|brand_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|vendor_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :vendor
- belongs_to :prefecture
- belongs_to :barnd
- belongs_to :size
- belongs_to :category
- has_many :item_images,dependent: :destroy
- has_many :item_comments,dependent: :destroy
- has_many :do_lists
- has_many :likes
- has_one :deal

## item_images
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|foreign_key: true|
### Association
- belongs_to :item

## brands
|Column|Type|Options|
|------|----|-------|
|brand|string|
### Association
- has_one :item

## sizes
|Column|Type|Options|
|------|----|-------|
|cloth|string|
|mens_shoes|string|
|ladies_shoes|string|
|kids_shoes|string|
|kid_cloth_small|string|
|kid_cloth|string|
|tv|string|
|bike|string|
|tire|string|
### Association
- has_one :item

## categories
|Column|Type|Options|
|------|----|-------|
|large|string|
|middle|string|
|small|string|
### Association
- has_one :item

## item_comments
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## vendors
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|bank|string|
|bank_account|string|
|branch_code|integer|
|account_number|integer|
|family_name|string|
|first_name|string|
|post_number|integer|
|prefecture_id|references|foreign_key: true|
|city|string|
|address|string|
|building_name|string|
### Association
- belongs_to :user
- belongs_to :prefecture
- has_many :items
- has_many :valuations
- has_many :points
- has_many :deals

## valuations
|Column|Type|Options|
|------|----|-------|
|satisfaction_level|string|null: false|
|comment|text|null: false|
|user_id|references|foreign_key: true|
|vendor_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :vendor

## likes
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## deals
|Column|Type|Options|
|------|----|-------|
|status|string|null: false|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|
|vendor_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :vendor
- belongs_to :item


