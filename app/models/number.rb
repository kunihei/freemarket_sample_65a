class Number < ApplicationRecord
  belongs_to :user, optional: true
end
