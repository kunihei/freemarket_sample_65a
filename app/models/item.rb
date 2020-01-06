class Item < ApplicationRecord
  has_one :address
  belongs_to :user
  # belongs_to :category
end
