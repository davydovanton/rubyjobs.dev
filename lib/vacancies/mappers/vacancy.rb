# frozen_string_literal: true

# TODO: & QUESTION: move this mapping to form object in web app?
module Vacancies
  module Mappers
    class Vacancy
      def call(payload) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        payload = Hash(payload)

        {
          vacancy: {
            position: payload[:position],
            position_type: payload[:position_type],

            details_raw: payload[:details_raw],

            location: payload[:location],
            remote_available: checkbox_to_bool(payload[:remote_available]),

            salary_min: payload[:salary][:min].to_i,
            salary_max: payload[:salary][:max].to_i,
            salary_currency: payload[:salary][:currency],
            salary_unit: payload[:salary][:unit],

            archived_in_weeks: payload[:archived_in_weeks].to_i,

            tags: payload[:tags].to_s.downcase.split(',').map!(&:strip)
          },

          contact: payload[:contact]
        }
      end

      private

      def checkbox_to_bool(value)
        value.to_i == 1
      end
    end
  end
end
