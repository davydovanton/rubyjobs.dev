# frozen_string_literal: true

module Web
  module Controllers
    module Companies
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'companies.operations.list'
        ]

        expose :companies

        def call(_params)
          result = operation.call

          case result
          when Success
            @companies = result.value!
          end
        end
      end
    end
  end
end
