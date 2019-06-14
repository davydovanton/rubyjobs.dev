# frozen_string_literal: true

module Vacancies
  module Operations
    class List < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      PAGINATION_LIMIT = 10

      def call(search_query: {}, page: 1)
        pager = vacancy_repo.pager_for_all_with_contact(limit: PAGINATION_LIMIT, page: page || 1)
        result = vacancy_repo.all_with_contact(limit: PAGINATION_LIMIT, page: page || 1)

        Success(result: result, pager: pager)
      end
    end
  end
end
