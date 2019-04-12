# frozen_string_literal: true

module Web
  module Helpers
    module AddUrlSchema
      private

      HTTP_SCHEMA_REGEXP = %r{\Ahttps?://}.freeze

      def add_url_schema(string)
        string[HTTP_SCHEMA_REGEXP] ? string : "http://#{string}"
      end
    end
  end
end
