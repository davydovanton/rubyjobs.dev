# frozen_string_literal: true

class VacancyAnalitic < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :view_count, Core::Types::ViewCount

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
