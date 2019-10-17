# frozen_string_literal: true

module Vacancies
  module Workers
    class VacanciesArchivator
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[
       :logger,
       :rollbar,
       operation: 'vacancies.operations.archive_for_today'
     ]

      def perform
        case result = operation.call
        when Success
          logger.info("archived #{result.value![:archived_count]} vacancies")
        when Failure
          rollbar.error('archived flow is broken')
        end
      end
    end
  end
end
