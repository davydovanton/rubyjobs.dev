# frozen_string_literal: true

module Vacancies
  module Mappers
    Container = Module.new do
      extend Transproc::Registry
      import Transproc::HashTransformations
      import Transproc::Coercions
      import Transproc::ClassTransformations
    end

    class SearchOptions < Transproc::Transformer[Container]
      symbolize_keys
      map_value :remote, t(:to_boolean)
      constructor_inject ::Vacancies::Entities::SearchOptions
    end
  end
end
