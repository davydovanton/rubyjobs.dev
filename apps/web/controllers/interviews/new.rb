# frozen_string_literal: true

module Web
  module Controllers
    module Interviews
      class New
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[operation: 'companies.operations.show']

        before :authenticate! # run an authentication before callback

        expose :company

        def call(params)
          result = operation.call(id: params[:company_id])
          case result
          when Success
            @company = result.value!
          when Failure
            redirect_to routes.companies_path
          end
        end
      end
    end
  end
end

