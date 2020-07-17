# frozen_string_literal: true

module Web
  module Controllers
    module Interviews
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          :rollbar, :logger,
          operation: 'interviews.operations.create',
          mapper: 'web.mappers.interview_form'
        ]

        before :authenticate! # run an authentication before callback

        def call(params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          payload = mapper.call({
            company_id: params[:company_id],
            account_id: current_account.id,
            interview: params[:interview]
          })
          result = operation.call(payload)

          case result
          when Success
            flash[:success] = 'Отзыв успешно создан.'
          when Failure
            flash[:fail] = 'Произошла ошибка, пожалуйста повторите позже'
            logger.error("fail on interview create, params: #{params.to_h}, result: #{result.failure}")
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
