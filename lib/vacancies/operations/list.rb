# frozen_string_literal: true

module Vacancies
  module Operations
    class List < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call(payload = {})
        Success(vacancy_repo.all_with_contact)
      end
    end
  end
end
