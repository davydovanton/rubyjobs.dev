# frozen_string_literal: true

module Web
  module Controllers
    module Companies
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'companies.operations.show',
          review_operation: 'reviews.operations.list'
        ]

        expose :company, :reviews

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @company = result.value!
            @reviews = review_operation.call(company_id: @company.id).value_or([])
          when Failure
            redirect_to routes.companies_path
          end
        end
      end
    end
  end
end
