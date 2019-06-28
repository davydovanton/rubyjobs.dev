# frozen_string_literal: true

module Web
  module Controllers
    module Vacancies
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          'libs.search_query_parser',
          operation: 'vacancies.operations.list'
        ]

        EMPTY_SEARCH_QUERY = {}.freeze

        expose :vacancies
        expose :pager

        params do
          optional(:page).filled
          optional(:query).filled
        end

        def call(params)
          result = operation.call(search_query: search_query, page: params[:page])

          case result
          when Success
            @pager     = result.value![:pager]
            @vacancies = result.value![:result]
          end
        end

        private

        Container = Module.new do
          extend Transproc::Registry
          import Transproc::HashTransformations
          import Transproc::Coercions
          import Transproc::ClassTransformations
        end

        class Transformer < Transproc::Transformer[Container]
          symbolize_keys
          map_value :remote, t(:to_boolean)
          constructor_inject ::Vacancies::Entities::SearchOptions
        end

        def search_query
          query_attributes = params[:query] ? search_query_parser.call(params[:query]) : EMPTY_SEARCH_QUERY
          initial_attributes = { remote: nil, position_type: nil, location: nil }
          Transformer.new.call(initial_attributes.merge(query_attributes))
        end
      end
    end
  end
end
