class Client < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 100 },uniqueness: { scope: :user,
        message: "is the same for two client" }
    belongs_to :user, counter_cache: :clients_count
    has_many :projects, class_name: "Project", foreign_key: "client_id", :dependent => :destroy
    has_many :times, class_name: "Saat", foreign_key: "client_id"

    scope :like, ->(field, value) { where arel_table[field].matches("%#{value}%") }

    before_create :checkMe
    def checkMe
        if user.isExpired
            errors.add(:base, "your account has been expire for about #{user.daysFromExpire} days ago, access to app for about #{user.daysRemaining} days")
            throw(:abort, "something went wrong")
        end
    end
end
