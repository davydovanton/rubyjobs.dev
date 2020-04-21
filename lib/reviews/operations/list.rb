# frozen_string_literal: true

module Reviews
  module Operations
    class List < ::Libs::Operation
      include Import[
        review_repo: 'repositories.review',
      ]

      def call(company_id:)
        Success(
          review_repo.all_for_companies(company_id)
        )
      end
    end
  end
end
