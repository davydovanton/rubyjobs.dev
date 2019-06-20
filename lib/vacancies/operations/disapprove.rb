# typed: ignore
# frozen_string_literal: true

module Vacancies
  module Operations
    class Disapprove < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call(id:)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          vacancy_repo.disapprove_by_pk(id)
        end.to_result
      end
    end
  end
end
