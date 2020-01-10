class Item < ApplicationRecord
  has_one :address
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user

  # belongs_to :category
  has_many :item_categories
  has_many :categories, through: :item_categories

  # image validates
  validates :name, :text, :price, presence: true
  # validates :genre, :status, :postage_selct, :prefecture_id, :delivery_day, inclusion: { in: [0] }
  validate :price_limit
  validates_associated :images

  def price_limit
    if price >= 0 && price <= 300
      errors.add(:price, ": out")
    elsif price < 0
      errors.add(:price, ": out")
    elsif price > 10000000
      errors.add(:price, ": out")
    end
  end

  validates :images, presence: true

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

  enum brand:{
    "---":0,
    シャネル:1,
    ナイキ:2,
    ルイヴィトン:3,
    シュプリーム:4,
    アディダス:5,
  },_prefix: true

  enum delivery_day:{
    "---":0,
    １〜２日で発送:1,
    ２〜３日で発送:2,
    ４〜７日で発送:3
  },_prefix: true

  enum deliver_method:{
    未定:0,
    '小型サイズ - ネコポス（らくらくメルカリ便）':1,
    '小型サイズ（A4）- ゆうパケット（ゆうゆうメルカリ便）':2,
    ゆうメール:3,
    ゆうパケット:4,
    レターパック:5,
    普通郵便（定形、定形外）:6,
    クリックポスト:7
  },_prefix: true

  enum order:{
    並び替え:0,
    価格の安い順:1,
    価格の高い順:2,
    出品の新しい順:3,
    いいね！の多い順:4
  },_prefix: true

  enum search_genre:{
    すべて:0,
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

  enum search_price:{
    選択してください:0,
    "300~1000":1,
    "1000~5000":2,
    "5000~10000":3,
    "10000~30000":4,
    "30000~50000":5,
    "50000~":6
  },_prefix: true

  enum search_size:{
    すべて:0,
    洋服のサイズ:1,
    メンズ靴のサイズ:2,
    レディース靴のサイズ:3,
    スカートのサイズ:4,
    キッズ服のサイズ:5,
    ベビー・キッズ靴のサイズ:6,
    ベビー服のサイズ:7,
    テレビのサイズ:8,
    カメラレンズのサイズ:9,
    オートバイのサイズ:10,
    ヘルメットのサイズ:11,
    タイヤのサイズ:12,
    スキーのサイズ:13,
    スノーボードのサイズ:14
  },_prefix: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  def self.search(search)
    if search
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  validates :name, :text, :genre, :status, :postage_selct, :prefecture_id, :delivery_day, :price, presence: true

end

