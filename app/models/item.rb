class Item < ApplicationRecord
  has_one :address
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user

  # belongs_to :category
  has_many :item_categories
  has_many :categories, through: :item_categories
  mount_uploader :src, ImageUploader

  enum genre:{
    "---":0,
    レディース:1,
    メンズ:2,
    ベビー・キッズ:3,
    インテリア・住まい・小物:4,
    本・音楽・ゲーム:5,
    おもちゃ・ホビー・グッズ:6,
    コスメ・香水・美容:7,
    家電・スマホ・カメラ:8,
    スポーツ・レジャー:9,
    ハンドメイド:10,
    チケット:11,
    自動車・オートバイ:12,
    その他:13
  },_prefix: true

  enum status:{
    "---":0,
    新品・未使用:1,
    未使用品に近い:2,
    目立った傷や汚れなし:3,
    やや傷や汚れあり:4,
    傷や汚れあり:5,
    全体的に状態が悪い:6
  },_prefix: true

  enum postage_selct:{
    "---":0,
    送料込み（出品者負担）:1,
    着払い（購入者負担）:2
  },_prefix: true

  enum delivery_day:{
    "---":0,
    １〜２日で発送:1,
    ２〜３日で発送:2,
    ４〜７日で発送:3
  },_prefix: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

end

