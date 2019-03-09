module Mutations
    class Login < BaseMutation
        null true
        argument :email, String, required: true
        argument :password, String, required: true

        field :token, String, null: true
        field :user, Types::UserType, null: true

        def resolve(email: nil, password: nil)
            return unless email
            user = User.find_by email: email
            return unless user
            return unless user.authenticate(password)
          
            payload = { data: user }
            rsa_private = OpenSSL::PKey::RSA.new(File.read("./config/private.pem"))

            token = JWT.encode payload, rsa_private, 'RS384'
            { user: user, token: token }
        end
    end
end