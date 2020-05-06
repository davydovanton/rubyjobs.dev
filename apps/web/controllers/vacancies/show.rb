# frozen_string_literal: true

module Web
  module Controllers
    module Vacancies
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.show',
          company_operation: 'companies.operations.show_by_name',
          analitics_operation: 'analitics.operations.increase_vacancy_view_count'
        ]

        expose :vacancy, :analitics, :company

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @vacancy = result.value!
            @analitics = analitics_operation.call(vacancy_id: params[:id]).value_or(VacancyAnalitic.new)
            @company = company_operation.call(name: @vacancy.contact.company).value_or(nil)
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
