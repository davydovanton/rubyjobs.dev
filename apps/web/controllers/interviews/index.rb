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

        expose :interviews, :company

        def call(params)
          result = interview_operation.call(company_id: params[:company_id].to_i)
          company_result = operation.call(id: params[:company_id].to_i)
          case result && company_result
          when Success
            @interviews = result.value_or([])
            @company = company_result.value!
          when Failure
            redirect_to routes.companies_path
          end
        end
      end
    end
  end
end
