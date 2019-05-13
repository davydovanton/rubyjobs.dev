# frozen_string_literal: true

module Subscribers
  module Operations
    class Create < ::Libs::Operation
      include Import[
        subscriber_repo: 'repositories.subscriber'
      ]

      EMAIL_VALIDATOR = Dry::Validation.JSON do
        required(:email).filled(format?: /\A[^@\s]+@[^@\s]+\.\w{1,3}\z/)
      end

      def call(email:)
        payload = yield EMAIL_VALIDATOR.call(email: email).to_either

        Try(Hanami::Model::UniqueConstraintViolationError) do
          subscriber_repo.create(payload)
        end.to_result
      end
    end
  end
end
