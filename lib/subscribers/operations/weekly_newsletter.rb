# frozen_string_literal: true

module Subscribers
  module Operations
    class WeeklyNewsletter < ::Libs::Operation
      include Import[
        subscriber_repo: 'repositories.subscriber'
      ]

      def call
        # subscriber_repo.all.each do |subscriber|
        #   subscriber.email
        # end
        Success(:ok)
      end
    end
  end
end
