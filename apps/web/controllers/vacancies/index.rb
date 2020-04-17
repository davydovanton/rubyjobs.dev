# frozen_string_literal: true

module Web
  module Controllers
    module Vacancies
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          'libs.search_query_parser',
          operation: 'vacancies.operations.list',
          search_options_mapper: 'web.mappers.search_options',
        ]

        expose :vacancies
        expose :pager

        params do
          optional(:page).filled
          optional(:query).filled
        end

        def call(params)
          result = operation.call(search_object: search_object, page: params[:page])

          case result
          when Success
            @pager     = result.value![:pager]
            @vacancies = result.value![:result]
          end
        end

        private

        def search_object
          Web::DTO::SearchOptions.new(
            search_options_mapper.call(
              search_query_parser.call(params[:query])
            )
          )
        end
      end
    end
  end
end
