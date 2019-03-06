module Types
  class QueryType < Types::BaseObject
    field :all_users, [UserType], null: false
    field :all_clients, [ClientType], null: false
    field :all_projects, [ProjectType], null: false
    def all_projects
      Project.all
    end
    def all_users
      User.all
    end
    def all_clients
      Client.all
    end
  end
end
