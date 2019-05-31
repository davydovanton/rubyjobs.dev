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
          logger.info(
            "weekly with #{vacancies_count} vacancies was delivered to #{result.value![:archived_count]} subscribers"
          )
        when Failure
          rollbar.error('error')
        end
      end
    end
  end
end
