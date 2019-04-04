require 'bcrypt'
class User < ApplicationRecord
    include BCrypt
    after_validation :bcryptPassword, if: :password_changed?
    validates :name, presence: true, length: { minimum: 3, maximun: 50 }
    validates :email, presence: true, uniqueness: true, email: true, length: { minimum: 6,maximun: 200 }
    validates :password, presence: true, length: { in: 6..20 }, if: :password_changed?

    has_many :clients, class_name: "Client", foreign_key: "user_id", dependent: :delete_all
    has_many :projects, class_name: "Project", foreign_key: "user_id", dependent: :delete_all
    has_many :times, class_name: "Saat", foreign_key: "user_id"

    def authenticate(pass)
        return Password.new(self.password) == pass
    end

    def isExpired 
        justNow = Time.parse Time.zone.now.to_s
        expired = true
        expiredAt = Time.parse self.expired_at.to_s
        totalSeconds = expiredAt - justNow
        if totalSeconds > 0
            expired = false
        end
        return expired
    end

    def daysFromExpire
        justNow = Time.parse Time.zone.now.to_s
        days = 0
        expiredAt = Time.parse self.expired_at.to_s
        totalSeconds = justNow - expiredAt
        if totalSeconds > 0
            days = totalSeconds / 86400
        end
        return days.ceil
    end
    def daysRemaining
        justNow = Time.parse Time.zone.now.to_s
        days = 0
        expiredAt = Time.parse self.expired_at.to_s
        totalSeconds = expiredAt - justNow
        if totalSeconds > 0
            days = totalSeconds / 86400
        end
        return days.floor
    end

    private 
    def bcryptPassword
        self.password = Password.create(self.password)
    end
end