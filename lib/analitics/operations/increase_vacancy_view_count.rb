# frozen_string_literal: true

module Analitics
  module Operations
    class IncreaseVacancyViewCount < ::Libs::Operation
      include Import[
      ]

      def call(vacancy_id:)
        Success(:ok)
      end
    end
  end
end
