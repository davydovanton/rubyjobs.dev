# frozen_string_literal: true

module Vacancies
  module Operations
    class Approve < ::Libs::Operation
      include Import[
        vacancy_repo: 'repositories.vacancy'
      ]

      def call(id:)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          vacancy_repo.approve_by_pk(id)
        end.to_result
      end
    end
  end
end
