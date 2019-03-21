require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

module Resolvers
    class ProjectsSearch < BaseResolver
        include SearchObject.module(:graphql)
        
        scope { Project.where(user: context[:current_user]) }

        type types[Types::ProjectType]
        
        # inline input type definition for the advance filter
        class ProjectFilter < Types::BaseInputObject
            argument :description_contains, String, required: false
            argument :name_contains, String, required: false
        end

        # when "filter" is passed "apply_filter" would be called to narrow the scope
        option :filter, type: ProjectFilter, with: :apply_filter
        option :first, type: types.Int, with: :apply_first
        option :skip, type: types.Int, with: :apply_skip
        option :status, type: types.Int, with: :apply_status

        # apply_filter recursively loops through "OR" branches
        def apply_filter(scope, value)
            branches = normalize_filters(value).reduce { |a, b| a.or(b) }
            scope.merge branches
        end

        def normalize_filters(value, branches = [])
            scope = Project.where(user: context[:current_user])
            scope = scope.like(:description, value[:description_contains]) if value[:description_contains]
            scope = scope.like(:name, value[:name_contains]) if value[:name_contains]

            branches << scope

            branches
        end

        def apply_first(scope, value)
            scope.limit(value)
        end
    
        def apply_skip(scope, value)
            scope.offset(value)
        end
        def apply_status(scope, value)
            scope.where(status: value)
        end

        def fetch_results
            # NOTE: Don't run QueryResolver during tests
            return super unless context.present?
        
            GraphQL::QueryResolver.run(Project, context, Types::ProjectType) do
              super
            end
        end

    end
end