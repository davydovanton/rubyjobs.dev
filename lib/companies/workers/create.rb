# frozen_string_literal: true

module Companies
  module Workers
    class Create
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[
       :rollbar,
       :logger,
       operation: 'companies.operations.create'
     ]

      def perform(name, url)
        company_payload = { name: name, url: url }

        case result = operation.call(payload: company_payload)
        when Success
          logger.info("created #{result.value!.name} company")
        when Failure
          rollbar.error("create company flow is broken, #{result.failure}")
        end
      end
    end
  end
end
