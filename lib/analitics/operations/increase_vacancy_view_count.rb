# typed: ignore
# frozen_string_literal: true

module Analitics
  module Operations
    class IncreaseVacancyViewCount < ::Libs::Operation
      include Import[
        vacancy_analitic_repo: 'repositories.vacancy_analitic'
      ]

      def call(vacancy_id:)
        Success(
          vacancy_analitic_repo.increase_view_count(vacancy_id)
        )
      end
    end
  end
end
