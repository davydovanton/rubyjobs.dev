# frozen_string_literal: true

module Web
  module Controllers
    module Subscribers
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'subscribers.operations.create'
        ]

        def call(params) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          result = operation.call(email: params[:subscriber][:email])

          case result
          when Success
            flash[:success] = "#{result.value!.email} успешно добавлен в рассылку."
            redirect_to routes.root_path
          when Failure { |error| error.is_a?(Hanami::Model::UniqueConstraintViolationError) }
            flash[:error] = 'Произошла ошибка, попробуйте позже или используйте другой почтовый адрес.'
            redirect_to routes.root_path
          when Failure
            flash[:error] = "Не валидная почта \"#{params[:subscriber][:email]}\"."
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
