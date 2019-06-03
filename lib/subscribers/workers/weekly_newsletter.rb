# frozen_string_literal: true

module Subscribers
  module Workers
    class WeeklyNewsletter
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[
        :logger,
        :rollbar,
        operation: 'subscribers.operations.weekly_newsletter'
      ]

      def perform
        case result = operation.call
        when Success
          payload = result.value!
          logger.info(
            "weekly with #{payload[:vacancies_count]} vacancies delivered to #{payload[:archived_count]} subscribers"
          )
        when Failure
          rollbar.error('error')
        end
      end
    end
  end
end
