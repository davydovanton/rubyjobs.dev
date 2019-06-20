# typed: ignore
# frozen_string_literal: true

module Web
  module Controllers
    module Vacancies
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          :rollbar, :logger,
          vacancy_mapping: 'vacancies.mappers.vacancy',
          operation: 'vacancies.operations.create'
        ]

        def call(params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          payload = vacancy_mapping.call(params[:vacancy])
          result = operation.call(**payload)

          case result
          when Success
            flash[:success] = 'Вакансия успешно отправлена на модерацию. В ближайшее время она появится на главной.'
            redirect_to routes.root_path
          when Failure
            flash[:fail] = 'Произошла ошибка, пожалуйста повторите позже'
            logger.error("fail on vacancy create, payload: #{payload}, result: #{result.failure}")
            rollbar.error(result.failure, payload: payload)
            redirect_to routes.root_path
          end
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
