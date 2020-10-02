# frozen_string_literal: true

module Interviews
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'libs.markdown_parser',
        'libs.telegram_sender',
        interview_repo: 'repositories.interview',
        company_repo: 'repositories.company'
      ]

      INTERVIEW_VALIDATOR = Dry::Validation.JSON do
        required(:author_id).filled(:int?)
        required(:company_id).filled(:int?)

        required(:body_raw).filled(:str?)
        required(:anonymous).filled(:bool?)

        required(:interview_rating).schema do
          required(:author_id).filled(:int?)

          required(:overall_impression).filled(:float?)
          required(:recommendation).filled(:float?)
        end
      end

      def call(payload)
        payload = yield INTERVIEW_VALIDATOR.call(payload).to_either
        payload[:body] = markdown_parser.call(payload[:body_raw])

        interview = yield persist_interview(payload)

        # TODO: move this line with company repo to separate worker
        company_repo.update_interview_statistic(payload[:company_id], payload[:interview_rating])
        send_notification(interview)

        Success(interview)
      end

      private

      def persist_interview(payload)
        Try(Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError) do
          interview_repo.create_with_interview_rating(payload)
        end.to_result
      end

      def send_notification(interview)
        message = "New interview for company!\n\nhttps://rubyjobs.dev/companies/#{interview.company_id}"
        Try { telegram_sender.call('@rubyjobs_dev_moderation', message) }
      end
    end
  end
end
