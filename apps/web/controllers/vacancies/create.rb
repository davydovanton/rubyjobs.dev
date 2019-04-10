module Web
  module Controllers
    module Vacancies
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          vacancy_mapping: 'vacancies.mappers.vacancy',
          operation: 'vacancies.operations.create'
        ]

        def call(params)
          payload = vacancy_mapping.call(params[:vacancy])
          result = operation.call(**payload)

          case result
          when Success
            redirect_to routes.root_path
          when Failure
            # redirect_to routes.project_path(params[:environment][:project_id])
          end
        end
      end
    end
  end
end
