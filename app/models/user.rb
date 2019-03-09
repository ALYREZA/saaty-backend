require 'bcrypt'
class User < ApplicationRecord
    include BCrypt
    after_validation :changePassword
    validates :name, presence: true, length: { minimum: 3, maximun: 50 }
    validates :email, presence: true, uniqueness: true, email: true, length: { minimum: 6,maximun: 200 }
    validates :password, presence: true, length: { in: 6..20 }
    def authenticate(pass)
        return Password.new(self.password) == pass
    end
    private 
    def changePassword
        self.password = Password.create(self.password)
    end
end