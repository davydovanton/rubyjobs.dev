# frozen_string_literal: true

module Reviews
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'libs.markdown_parser',
        'libs.telegram_sender',
        review_repo: 'repositories.review',
        company_repo: 'repositories.company'
      ]

      REVIEW_VALIDATOR = Dry::Validation.JSON do
        required(:author_id).filled(:int?)
        required(:company_id).filled(:int?)

        required(:body_raw).filled(:str?)
        required(:anonymous).filled(:bool?)

        required(:rating).schema do
          required(:author_id).filled(:int?)

          required(:salary_value).filled(:float?)
          required(:office).filled(:float?)
          required(:working_time).filled(:float?)
          required(:project_interest).filled(:float?)
          required(:atmosphere).filled(:float?)
          required(:personal_growth).filled(:float?)
          required(:modern_technologies).filled(:float?)
          required(:management_level).filled(:float?)
          required(:team_level).filled(:float?)
        end
      end

      def call(payload)
        payload = yield REVIEW_VALIDATOR.call(payload).to_either
        payload[:body] = markdown_parser.call(payload[:body_raw])

        review = yield persist_review(payload)

        # TODO: move this line with company repo to separate worker
        company_repo.update_statistic(payload[:company_id], payload[:rating])
        send_notification(review)

        Success(review)
      end

      private

      def persist_review(payload)
        Try(Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError) do
          review_repo.create_with_rating!(payload)
        end.to_result
      end

      def send_notification(review)
        message = "New review for company!\n\nhttps://rubyjobs.dev/companies/#{review.company_id}"
        Try { telegram_sender.call('@rubyjobs_dev_moderation', message) }
      end
    end
  end
end
