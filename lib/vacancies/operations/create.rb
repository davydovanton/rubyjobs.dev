# frozen_string_literal: true

module Vacancies
  module Operations
    class Create < ::Libs::Operation
      def call(_payload = nil)
        Success(Vacancy.new)
      end
    end
  end
end
