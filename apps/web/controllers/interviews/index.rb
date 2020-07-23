module Web
  module Controllers
    module Interviews
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
                    operation: 'companies.operations.show',
                    interview_operation: 'interviews.operations.list'
                ]

        expose :company, :interviews

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @company = result.value!
            @reviews = interview_operation.call(company_id: @company.id).value_or([])
          when Failure
            redirect_to routes.companies_path
          end
        end
      end
    end
  end
end
