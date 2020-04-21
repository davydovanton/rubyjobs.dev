# frozen_string_literal: true

module Companies
  module Operations
    class List < ::Libs::Operation
      include Import[
        repo: 'repositories.company'
      ]

      def call
        Success(repo.all_with_reviews)
      end
    end
  end
end
