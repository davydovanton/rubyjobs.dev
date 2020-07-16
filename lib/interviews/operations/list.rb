# frozen_string_literal: true

module Interviews
  module Operations
    class List < ::Libs::Operation
      include Import[
                  interview_repo: 'repositories.interview',
              ]

      def call(company_id:)
        Success(
            interview_repo.all_for_companies(company_id)
        )
      end
    end
  end
end
