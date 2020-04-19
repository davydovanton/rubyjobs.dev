# frozen_string_literal: true

module Companies
  module Operations
    class Create < ::Libs::Operation
      include Import[
        repo: 'repositories.company'
      ]

      Dry::Validation.load_extensions(:monads)

      VALIDATOR = Dry::Validation.JSON do
        required(:name).filled(:str?)
        required(:url).filled(:str?)
      end

      def call(payload:)
        payload = yield VALIDATOR.call(payload).to_either
        company = yield company_exist?(Company.new(payload))

        Success(repo.create(company))
      end

      private

      def company_exist?(company)
        repo.already_exist?(company) ? Failure(:already_exists) : Success(company)
      end
    end
  end
end
