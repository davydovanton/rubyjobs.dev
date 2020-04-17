# frozen_string_literal: true

module Web
  module Mappers
    class SearchOptions
      def call(params)
        {
          remote: to_bool(params[:remote]),
          position_type: params[:position_type],
          location: params[:location]
        }
      end

      private

      def to_bool(value)
        case value
        when 'true'  then true
        when 'false' then false
        end
      end
    end
  end
end
