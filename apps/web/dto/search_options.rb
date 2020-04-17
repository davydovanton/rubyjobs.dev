# frozen_string_literal: true

module Web
  module DTO
    # Data Transfer Object with information about search query wich we use in root page for filters
    class SearchOptions < Dry::Struct
      constructor_type :schema

      attribute :position_type, Core::Types::VacancyPositionTypes.optional.default(nil)
      attribute :location,      Core::Types::Strict::String.optional.default(nil)
      attribute :remote,        Core::Types::Strict::Bool.optional.default(nil)
      attribute :text,          Core::Types::Strict::String.optional.default(nil)
    end
  end
end
