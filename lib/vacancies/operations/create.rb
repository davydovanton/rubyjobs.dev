# frozen_string_literal: true

module Vacancies
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'libs.markdown_parser',
        vacancy_repo: 'repositories.vacancy',
        contact_repo: 'repositories.contact'
      ]

      Dry::Validation.load_extensions(:monads)

      VACANCY_VALIDATOR = Dry::Validation.JSON do
        required(:position).filled(:str?)
        required(:position_type).filled(:str?)

        required(:details_raw).filled(:str?)

        required(:location).filled(:str?)
        required(:remote_available).filled(:bool?)

        required(:salary_min).filled(:int?)
        required(:salary_max).filled(:int?)
        required(:salary_currency).filled(:str?)
        required(:salary_unit).filled(:str?)

        required(:archived_in_weeks).filled(:int?)
      end

      CONTACT_VALIDATOR = Dry::Validation.JSON do
        required(:email).filled(:str?)
        required(:full_name).filled(:str?)

        optional(:company).maybe(:str?)
        optional(:site).maybe(:str?)
      end

      def call(contact:, vacancy:)
        company_payload = yield CONTACT_VALIDATOR.call(contact).to_either
        vacancy_payload = yield VACANCY_VALIDATOR.call(vacancy).to_either

        vacancy_payload[:details] = markdown_parser.call(vacancy_payload[:details_raw])
        vacancy_payload[:published] = false
        vacancy_payload[:archived_at] = calculate_archive_date(vacancy_payload[:archived_in_weeks])
        vacancy_payload.delete(:archived_in_weeks)

        persist_vacancy(company_payload, vacancy_payload)
      end

      private

      # seconds * minutes * hours * days
      WEEK = 60 * 60 * 24 * 7

      def calculate_archive_date(archived_in_weeks)
        (Time.now + archived_in_weeks * WEEK).to_date
      end

      def persist_vacancy(company_payload, vacancy_payload)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          vacancy_repo.transaction do
            contact = contact_repo.create(company_payload)
            vacancy_repo.create(**vacancy_payload, contact_id: contact.id)
          end
        end.to_result
      end
    end
  end
end
