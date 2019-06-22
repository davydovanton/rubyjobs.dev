# frozen_string_literal: true

module Vacancies
  module Operations
    class List < ::Libs::Operation
      include Import[
        vacancy_query: 'queries.vacancy'
      ]

      PAGINATION_LIMIT = 10

      def call(search_query: {}, page: 1, remote_query: nil) # rubocop:disable Lint/UnusedMethodArgument
        remote_available = { 'true' => true, 'false' => false }[remote_query]
        pager = vacancy_query.pager_for_all_with_contact(limit: PAGINATION_LIMIT, page: page || 1, remote_available: remote_available)
        result = vacancy_query.all_with_contact(limit: PAGINATION_LIMIT, page: page || 1, remote_available: remote_available)

        Success(result: result, pager: pager)
      end
    end
  end
end
