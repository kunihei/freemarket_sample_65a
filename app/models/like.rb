class Like < ApplicationRecord
  belongs_to :item, counter_cache: :likes_count
  belongs_to :user
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates_uniqueness_of :item_id, scope: :user_id
end
