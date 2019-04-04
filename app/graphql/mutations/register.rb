module Mutations
    class Register < BaseMutation
        argument :name, String, required: true
        argument :email, String, required: true
        argument :password, String, required: true

        type Types::UserType

        def resolve(name: nil, email: nil, password: nil)
            User.create!(
                name: name,
                email: email,
                password: password,
                expired_at: Time.zone.now + 7.day
            )
            
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end