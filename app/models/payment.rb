class Payment < ApplicationRecord
  validates :payment_id, presence: true, uniqueness: true
  belongs_to :user
end
