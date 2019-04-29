# frozen_string_literal: true

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
        expose :pager

        params do
          optional(:page).filled
        end

        def call(params)
          result = operation.call(params.to_h)

          case result
          when Success
            @pager     = result.value![:pager]
            @vacancies = result.value![:result]
          end
        end
      end
    end
  end
end
