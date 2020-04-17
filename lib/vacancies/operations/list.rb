# frozen_string_literal: true

module Vacancies
  module Operations
    class List < ::Libs::Operation
      include Import[
        vacancy_query: 'vacancies.queries.vacancy'
      ]

      PAGINATION_LIMIT = 10

      def call(search_object: {}, page: 1)
        pager = vacancy_query.pager_for_all_with_contact(
          limit: PAGINATION_LIMIT,
          page: page || 1,
          search_object: search_object
        )
        result = vacancy_query.all_with_contact(limit: PAGINATION_LIMIT, page: page || 1, search_object: search_object)

        Success(result: result, pager: pager)
      end
    end
  end
end
