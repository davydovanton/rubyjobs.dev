module Web
  module Controllers
    module Vacancies
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.list'
        ]

        expose :vacancies

        def call(params)
          result = operation.call(params)

          case result
          when Success
            @vacancies = result.value!
          when Failure
            # redirect_to routes.project_path(params[:environment][:project_id])
          end
        end
      end
    end
  end
end
