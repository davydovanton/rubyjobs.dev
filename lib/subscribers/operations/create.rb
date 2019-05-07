# frozen_string_literal: true

module Subscribers
  module Operations
    class Create < ::Libs::Operation
      include Import[
      ]

      def call(email:)
        Success(Subscriber.new(email: email))
      end
    end
  end
end
