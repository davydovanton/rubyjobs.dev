# frozen_string_literal: true

module Vacancies
  module Mappers
    class SearchOptions
      def call(params)
        payload = {
          remote: to_bool(params[:remote]),
          position_type: params[:position_type],
          location: params[:location]
        }

        Vacancies::Entities::SearchOptions.new(payload)
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
