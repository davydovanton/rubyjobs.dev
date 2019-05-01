# frozen_string_literal: true

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
            flash[:success] = 'Вакансия успешно отправлена на модерацию. В ближайшее время она появится на главной.'
            redirect_to routes.root_path
            # TODO: log and trigger rollbar in this case. Also, show new page again
            #
            # when Failure
            #   redirect_to routes.project_path(params[:environment][:project_id])
          end
        end
      end
    end
  end
end
