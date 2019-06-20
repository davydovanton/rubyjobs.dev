# typed: ignore
# frozen_string_literal: true

module Moderation
  module Controllers
    module VacancyDisapprove
      class Update
        include Moderation::Action
        include Dry::Monads::Result::Mixin
        include Import[
          :rollbar,
          operation: 'vacancies.operations.disapprove'
        ]

        expose :vacancies

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            redirect_to routes.root_path
          when Failure
            rollbar.error(result.failure)
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
