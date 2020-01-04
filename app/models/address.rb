class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  belongs_to :item, optional: true

  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :postcode, presence: true, format: { with: /\A\d{3}[-]\d{4}\z/ }
  validates :city, presence: true
  validates :block, presence: true
  validates :tell, uniqueness: true, format: { with:  /\A\d{11}\z/ }
end
