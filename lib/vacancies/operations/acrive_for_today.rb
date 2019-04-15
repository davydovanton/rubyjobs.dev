# frozen_string_literal: true

module Vacancies
  module Operations
    class AcriveForToday < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call
        Success(archived_count: vacancy_repo.archive_for_today)
      end
    end
  end
end
