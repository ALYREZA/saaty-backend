class Client < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 100 },uniqueness: { scope: :user,
        message: "is the same for two client" }
    belongs_to :user, counter_cache: :clients_count
    has_many :projects, class_name: "Project", foreign_key: "client_id", :dependent => :destroy
    has_many :times, class_name: "Saat", foreign_key: "client_id"
end
