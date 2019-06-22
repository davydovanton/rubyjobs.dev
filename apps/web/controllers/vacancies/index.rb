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
        expose :remote_filter_param

        params do
          optional(:page).filled
          optional(:query).filled
          optional(:remote_filter).filled
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

        def search_query
          params[:query] ? search_query_parser.call(params[:query]) : EMPTY_SEARCH_QUERY
        end

        def remote_filter_param
          @remote_filter_param ||= (params[:remote_filter] || 'all')
        end
      end
    end
  end
end
