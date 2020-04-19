# frozen_string_literal: true

module Companies
  module Operations
    class Show < ::Libs::Operation
      include Import[
        repo: 'repositories.company'
      ]

      def call(id:)
        company = repo.find(id)
        company ? Success(company) : Failure(:not_found)
      end
    end
  end
end
