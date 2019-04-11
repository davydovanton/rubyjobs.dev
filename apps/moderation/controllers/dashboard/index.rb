module Moderation
  module Controllers
    module Dashboard
      class Index
        include Moderation::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'vacancies.operations.list_for_moderation'
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
