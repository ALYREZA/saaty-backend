module Mutations
    class EditProject < BaseMutation
        argument :uuid, String, required: true
        argument :cost, Float, required: false
        argument :budget, Float, required: false
        argument :budget_type, Int, required: false
        argument :status, Int, required: false
        argument :name, String, required: false
        argument :color, String, required: false
        argument :description, String, required: false

        type Types::ProjectType

        def resolve(uuid: nil,cost: nil, budget: nil,budget_type: nil,status: nil, name: nil, color: nil, description: nil  )
            project = Project.find_by!(uuid: uuid, user: context[:current_user])
            project.cost = cost if cost
            project.budget = budget if budget
            project.budget_type = budget_type
            project.status = status if status
            project.name = name if name
            project.color = color if color
            project.description = description if description
            return project if project.save!

        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")

        end
    end
end