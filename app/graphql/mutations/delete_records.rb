module Mutations
    class DeleteRecords < BaseMutation
        argument :uuids, [String], required: true

        type [Types::SaatType]

        def resolve(uuids: nil)
            times = Saat.where(uuid: uuids, user: context[:current_user]).destroy_all            
            return times
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end