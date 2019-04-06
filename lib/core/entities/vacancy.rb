class Contact < Hanami::Entity
end

class Vacancy < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :contact_id, Types::Int

    attribute :position, Types::String
    attribute :position_type, Core::Types::VacancyPositionTypes

    attribute :details_raw, Types::String
    attribute :details,     Types::String

    attribute :location, Types::String
    attribute :remote_available, Types::Bool

    attribute :archived, Types::Bool

    attribute :contact, Types::Entity(Contact)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
    attribute :archived_at, Types::Time
  end
end
