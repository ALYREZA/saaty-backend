class Client < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 100 }
    belongs_to :user
end
