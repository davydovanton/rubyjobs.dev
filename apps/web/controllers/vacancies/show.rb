# typed: ignore
# frozen_string_literal: true

module Web
  module Controllers
    module Vacancies
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.show',
          analitics_operation: 'analitics.operations.increase_vacancy_view_count'
        ]

        expose :vacancy, :analitics

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @vacancy = result.value!
            @analitics = analitics_operation.call(vacancy_id: params[:id]).value_or(VacancyAnalitic.new)
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
