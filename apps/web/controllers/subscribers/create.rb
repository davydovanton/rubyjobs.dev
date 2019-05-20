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

        def call(params)
          result = operation.call(email: params[:subscriber][:email])

          case result
          when Success
            flash[:success] = "#{result.value!.email} успешно добавлен в рассылку."
            redirect_to routes.root_path
          when Failure
            flash[:error] = 'Произошла ошибка, попробуйте позже.'
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
