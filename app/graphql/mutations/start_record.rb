module Mutations
    class StartRecord < BaseMutation
        argument :start, String, required: true
        argument :client_uuid, String, required: true
        argument :project_uuid, String, required: true

        type Types::SaatType

        def resolve(start: nil, client_uuid: nil, project_uuid: nil)
            Saat.create!(
                uuid: UUIDTools::UUID.random_create,
                start: Chronic.parse(start.to_s, :context => :past, :now => Time.zone.now) ? Chronic.parse(start.to_s, :context => :past, :now => Time.zone.now) : Chronic.parse("this second", :context => :past, :now => Time.zone.now),
                client: Client.find_by!(uuid: client_uuid, user: context[:current_user]),
                user: context[:current_user],
                project: Project.find_by!(uuid: project_uuid, user: context[:current_user])
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end