# frozen_string_literal: true

module Web
  module Mappers
    class ReviewForm
      def call(company_id, account_id, params)
        {
          author_id: account_id,
          company_id: company_id.to_i,

          body_raw: params[:body_raw],
          anonymous: to_bool(params[:anonymous]),

          rating: {
            author_id: account_id,

            salary_value:        params[:rating][:salary_value].to_f,
            office:              params[:rating][:office].to_f,
            working_time:        params[:rating][:working_time].to_f,
            project_interest:    params[:rating][:project_interest].to_f,
            atmosphere:          params[:rating][:atmosphere].to_f,
            personal_growth:     params[:rating][:personal_growth].to_f,
            modern_technologies: params[:rating][:modern_technologies].to_f,
            management_level:    params[:rating][:management_level].to_f,
            team_level:          params[:rating][:team_level].to_f
          }
        }
      end

      private

      def to_bool(value)
        case value
        when 'true'  then true
        when 'false' then false
        else
          false
        end
      end
    end
  end
end
