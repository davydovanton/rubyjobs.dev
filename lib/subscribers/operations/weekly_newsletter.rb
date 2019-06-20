# typed: ignore
# frozen_string_literal: true

module Subscribers
  module Operations
    class WeeklyNewsletter < ::Libs::Operation
      include Import[
        subscriber_repo: 'repositories.subscriber'
      ]

      def call
        subscribers = []
        vacancies = []
        # subscribers = subscriber_repo.all
        # subscribers.each do |subscriber|
        #   subscriber.email
        # end
        Success(subscribers_count: subscribers.count, vacancies_count: vacancies.count)
      end
    end
  end
end
