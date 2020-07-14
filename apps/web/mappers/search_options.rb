# frozen_string_literal: true

module Web
  module Mappers
    class SearchOptions
      def call(params)
        {
          position_type: check_position_type(params[:position_type]),
          location: params[:location],
          salary: to_int(params[:salary]),
          salary_currency: check_currency(params[:salary_currency], params[:salary]),
          remote: to_bool(params[:remote]),
          text: params[:text]
        }
      end

      private

      def check_position_type(value)
        value if Core::Types::VacancyPositionTypes.values.include?(value)
      end

      def check_currency(value, salary)
        if value.nil? && !salary.nil?
          'rub'
        elsif Core::Types::VacancySalaryCurrencyTypes.values.include?(value)
          value
        end
      end

      def to_bool(value)
        case value
        when 'true'  then true
        when 'false' then false
        end
      end

      def to_int(value)
        value&.to_i
      end
    end
  end
end
