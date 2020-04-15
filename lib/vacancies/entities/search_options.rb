# frozen_string_literal: true

module Vacancies
  module Entities
    class SearchOptions < Dry::Struct
      attribute :remote, Core::Types::Strict::Bool.optional.default(nil)
      attribute :position_type, Core::Types::VacancyPositionTypes.optional.default(nil)
      attribute :location, Core::Types::Strict::String.optional.default(nil)
    end
  end
end
