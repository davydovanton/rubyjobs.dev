# frozen_string_literal: true

module Vacancies
  module Operations
    class VacancyForModeration < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call(id:)
        vacancy = vacancy_repo.find_for_moderation(id)
        vacancy ? Success(vacancy) : Failure(:not_found)
      end
    end
  end
end
