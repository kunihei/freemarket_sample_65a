

## users テーブル
|Column|Type|Options|
|------|----|-------|
|avatar_image   |text   |                                   <!-- アイコン -->
|introduction   |text   |                                   <!-- 自己紹介文 -->
|nickname       |string |null: false|                       <!-- ニックネーム -->
|email          |string |null: false, add_index, unique :true|<!-- メアド -->
|password       |string |null: false|                       <!-- パス --> 
|last_name      |string |null: false|                       <!-- 苗字 -->
|first_name     |string |null: false|                       <!-- 名前 -->
|last_name_kana |string |null: false|                       <!-- 苗字（カナ） -->
|first_name_kana|string |null: false|                       <!-- 名前(カナ) -->
|birthday       |date   |null: false|                       <!-- 誕生日 --> 
### Association
has_many :prefs
has_many :likes
has_many :addresses
has_many :commnets
has_many :items
has_many :reviews


## prefs テーブル
|Column|Type|Options|
|------|----|-------|
|name   |string |null: false|                               <!-- 都道府県-->
|user_id|integer|null: false, foreign_key: true|            <!-- 外部キー-->
### Association
belongt_to :user


## addresses テーブル
|Column|Type|Options|
|------|----|-------|
|postcode |string |null: false|                              <!-- 郵便番号 -->
|city     |string |null: false|                              <!-- 市町村 -->
|block    |string |null: false|                              <!-- 番地 -->
|building |string |                                          <!-- 建物名 任意-->
|tell     |string |null: false, add_index, unique :true|     <!-- 電話番号 -->
|user_id  |integer|null: false, foreign_key: true|           <!-- 外部キー-->
|pref_id  |integer|null: false, foreign_key: true|           <!-- 外部キー-->
### Association
belongt_to :user


## items テーブル
|Column|Type|Options|
|------|----|-------|
|name           |string |null: fals|
|text           |text   |null: fals|              <!-- 商品説明欄-->
|status         |integer|default: 0, null: false| <!-- 商品状態 enum-->
|delivery_method|integer|default: 0, null: false| <!-- 配送方法 enum-->
|delivery_day   |integer|default: 0, null: false| <!-- 配送までの日数 enum-->
|pref           |integer|default: 0, null: false| <!-- 発送地域--> 
|postage_selct  |integer|default: 0, null: false| <!-- 送料負担-->
|price          |integer|null: false|              <!-- 価格-->
|size           |integer|default: 0|              <!-- サイズ enum-->
|user_id        |null: false, foreign_key: true|
|brand_id       |null: false, foreign_key: true|
### Association
has_many :likes
has_many :comments
has_many :photos
has_many :items_catgoriess
has_many :category through: :items_catgories
belongs_to :brand
belongs_to :user


## categories テーブル
|Column|Type|Options|
|------|----|-------|
|genre   |integer|default: 0,null false|<!-- カテゴリ大-->
|subgenre|integer|default: 0,null false|<!-- カテゴリ中-->
|detail  |integer|default: 0,null false|<!-- カテゴリ小-->
### Association
has_many :items_catgories
has_many :items through: :items_catgoriess



## items_categories テーブル（中間テーブル）
|Column|Type|Options|
|------|----|-------|
|item_id    |null: false, foreign_key: true|<!-- 外部キー-->
|category_id|null: false, foreign_key: true|<!-- 外部キー-->
### Association
belongs_to :item
belongs_to :category


## photo テーブル
|Column|Type|Options|
|------|----|-------|
|url    |text   |null: false|<!-- 最低一枚必須？--><!-- 商品写真-->
|item_id|integer|null: false,foreign_key: true|
### Association
belongs_to :item


##  brand テーブル
|Column|Type|Options|
|------|----|-------|
|name  |strung|           <!-- カテゴリー選択後必要なら--><!-- ブランド名-->
### Association
hasmany :items



## 良いね
|Column|Type|Options|
|------|----|-------|              
|item_id|integer|null false,foreign_key: true|<!-- 外部キー -->
|user_id|integer|null false,foreign_key: true|<!-- 外部キー -->
### Association
belongs_to :item
belongs_to :user

## comment
|Column|Type|Options|
|------|----|-------|
|messge |text   |null: false|<!-- コメント-->
|item_id|integer|null false,foreign_key: true|<!-- item外部キー -->
|user_id|integer|null false,foreign_key: true|<!-- user外部キー -->
### Association
belongs_to :user
belongs_to :item

## review
|Column|Type|Options|
|------|----|-------|
|evaluation |integer|null: false|<!-- 評価    enum-->
|message    |text   |null: false|<!-- 評価文  enum-->
|user_id    |integer|null false,foreign_key: true|<!-- user外部キー -->
### Association
belongs_to :user
