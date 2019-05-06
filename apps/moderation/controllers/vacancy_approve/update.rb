# frozen_string_literal: true

module Moderation
  module Controllers
    module VacancyApprove
      class Update
        include Moderation::Action
        include Dry::Monads::Result::Mixin

        include Import[
          :rollbar,
          operation: 'vacancies.operations.approve'
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
      end
    end
  end
end
