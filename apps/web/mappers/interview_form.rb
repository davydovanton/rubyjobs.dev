# frozen_string_literal: true

module Web
  module Mappers
    class InterviewForm
      def call(company_id, account_id, params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        {
          author_id: account_id,
          company_id: company_id.to_i,

          body_raw: params[:body_raw],
          anonymous: to_bool(params[:anonymous]),

          interview_rating: {
            author_id: account_id,

            overall_impression: params[:interview_rating][:overall_impression].to_f,
            recommendation: params[:interview_rating][:recommendation].to_f
          }
        }
      end

      private

      def to_bool(value)
        case value
        when 'true', '1', 1  then true
        when 'false', '0', 0 then false
        else
          false
        end
      end
    end
  end
end

