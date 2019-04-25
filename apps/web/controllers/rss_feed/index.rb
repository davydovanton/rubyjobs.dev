# frozen_string_literal: true

module Web
  module Controllers
    module RssFeed
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'vacancies.operations.list'
        ]

        def call(_params)
          self.format = :xml

          result = operation.call

          case result
          when Success
            self.body = Views::RssFeed::Generator.new.call(vacancies: result.value![:result])
          when Failure
            self.status = 422
            self.body = 'Failure'
          end
        end
      end
    end
  end
end
