require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

module Resolvers
    class RecordsSearch < BaseResolver
        include SearchObject.module(:graphql)
        
        scope { Saat.where(user: context[:current_user]) }

        type types[Types::SaatType]

        # inline input type definition for the advance filter
        class SaatFilter < Types::BaseInputObject
            argument :projects, [String], required: false
        end

        # when "filter" is passed "apply_filter" would be called to narrow the scope
        option :filter, type: SaatFilter, with: :apply_filter
        option :first, type: types.Int, with: :apply_first
        option :skip, type: types.Int, with: :apply_skip

        # apply_filter recursively loops through "OR" branches
        def apply_filter(scope, value)
            branches = normalize_filters(value).reduce { |a, b| a.or(b) }
            scope.merge branches
        end

        def normalize_filters(value, branches = [])
            scope = Saat.where(user: context[:current_user])
            # = scope.where()

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
        
            GraphQL::QueryResolver.run(Saat, context, Types::SaatType) do
              super
            end
        end


    end
end