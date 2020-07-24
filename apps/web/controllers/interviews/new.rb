# frozen_string_literal: true

module Web
  module Controllers
    module Interviews
      class New
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          :rollbar, :logger,
          operation: 'companies.operations.show'
        ]

        before :authenticate! # run an authentication before callback

        expose :company

        def call(params)
          result = operation.call(id: params[:company_id])
          case result
          when Success
            @company = result.value!
          when Failure
            logger.error("fail on interview new, params: #{params.to_h}, result: #{result.failure}")
            rollbar.error(result.failure, payload: params.to_h)
            redirect_to routes.companies_path
          end
        end
      end
    end
  end
end
