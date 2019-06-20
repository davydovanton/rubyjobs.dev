# typed: ignore
# frozen_string_literal: true

module Vacancies
  module Operations
    class ListForModeration < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call(_payload = {})
        Success(vacancy_repo.all_for_moderation)
      end
    end
  end
end
