class Number < ApplicationRecord
  belongs_to :user, optional: true

  validates :tell, presence: true, uniqueness: true, format: { with:  /\A\d{11}\z/ }
end
