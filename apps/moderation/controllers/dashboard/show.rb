# frozen_string_literal: true

module Moderation
  module Controllers
    module Dashboard
      class Show
        include Moderation::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.vacancy_for_moderation'
        ]

        expose :vacancy

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @vacancy = result.value!
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
