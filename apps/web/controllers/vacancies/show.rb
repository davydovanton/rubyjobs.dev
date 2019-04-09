module Web
  module Controllers
    module Vacancies
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.show'
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
