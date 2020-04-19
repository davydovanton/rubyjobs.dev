# frozen_string_literal: true

module Companies
  module Operations
    class Create < ::Libs::Operation
      include Import[
      ]

      def call
        Success(true)
      end
    end
  end
end
