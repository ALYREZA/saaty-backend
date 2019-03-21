module Types
  class QueryType < Types::BaseObject
    field :all_users, [UserType], null: false
    field :all_clients, [ClientType], null: false
    field :clients, function: Resolvers::ClientsSearch
    field :projects, function: Resolvers::ProjectsSearch
    field :all_saats, [SaatType], null: false
    field :records, function: Resolvers::RecordsSearch
    def all_users
      User.all
    end
  end
end
