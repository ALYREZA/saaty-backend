module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :create_client, mutation: Mutations::CreateClient
    field :create_project, mutation: Mutations::CreateProject
    field :start, mutation: Mutations::StartRecord
    field :stop, mutation: Mutations::EndRecord
    field :edit_user, mutation: Mutations::EditUser
    field :edit_client, mutation: Mutations::EditClient
    field :edit_project, mutation: Mutations::EditProject
    field :delete_client, mutation: Mutations::DeleteClient
    field :delete_projects, mutation: Mutations::DeleteProjects
    field :delete_records, mutation: Mutations::DeleteRecords
  end
end
