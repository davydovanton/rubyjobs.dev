# frozen_string_literal: true

module Reviews
  module Operations
    class Create < ::Libs::Operation
      include Import[
      ]

      def call(**params)
        Success(true)
      end
    end
  end
end
