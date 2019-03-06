module Types
  class QueryType < Types::BaseObject
    field :all_users, [UserType], null: false
    field :all_clients, [ClientType], null: false
    field :all_projects, [ProjectType], null: false
    field :all_saats, [SaatType], null: false

    def all_saats
      Saat.all
    end
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
