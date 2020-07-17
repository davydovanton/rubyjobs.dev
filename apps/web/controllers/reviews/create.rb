# frozen_string_literal: true

module Web
  module Controllers
    module Reviews
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          :rollbar, :logger,
          operation: 'reviews.operations.create',
          mapper: 'web.mappers.review_form'
        ]

        before :authenticate! # run an authentication before callback

        def call(params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          payload = mapper.call(params[:company_id], current_account.id, params[:review])
          result = operation.call(payload)

          case result
          when Success
            flash[:success] = 'Отзыв успешно создан.'
          when Failure
            flash[:fail] = 'Произошла ошибка, пожалуйста повторите позже'
            logger.error("fail on review create, params: #{params.to_h}, result: #{result.failure}")
            rollbar.error(result.failure, payload: params.to_h)
          end

          redirect_to routes.company_path(params[:company_id])
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
