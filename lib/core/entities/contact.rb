# typed: ignore
# frozen_string_literal: true

class Vacancy < Hanami::Entity
end

class Contact < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :email, Types::String
    attribute :full_name, Types::String
    attribute :company, Types::String
    attribute :site, Types::String

    attribute :vacancy, Types::Entity(Vacancy)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
