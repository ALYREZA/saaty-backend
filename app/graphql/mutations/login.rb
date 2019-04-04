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
          
            payload = {data: user.id}
            rsa_private = File.read("./config/master.key")
            token = JWT.encode payload, rsa_private, 'HS256'
            context[:session][:token] = token
            { user: user, token: token }
        end
    end
end