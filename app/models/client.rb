class Client < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 100 }
    belongs_to :user
    has_many :projects, class_name: "Project", foreign_key: "client_id", dependent: :delete_all
    has_many :times, class_name: "Saat", foreign_key: "client_id"
end
