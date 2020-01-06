class Item < ApplicationRecord
  has_one :address
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user

  # belongs_to :category
  has_many :item_categories
  has_many :categories, through: :item_categories
  mount_uploader :src, ImageUploader

end

