module Mutations
    class EditUser < BaseMutation
        argument :name, String, required: false
        argument :password, String, required: false
        argument :zone, String, required: false

        type Types::UserType
        
        def resolve(name: nil, password: nil, zone: nil)
            user = User.find_by(id: context[:current_user].id)
            user.name = name if name
            user.password = password if password
            user.zone = zone if zone
            if user.save!
                return user
            end
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end