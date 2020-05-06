# frozen_string_literal: true

module Companies
  module Operations
    class ShowByName < ::Libs::Operation
      include Import[
        repo: 'repositories.company'
      ]

      def call(name:)
        company = repo.find_by_name(name)
        company ? Success(company) : Failure(:not_found)
      end
    end
  end
end
