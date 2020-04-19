# frozen_string_literal: true

class Account < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :github, Types::String
    attribute :email, Types::String
    attribute :name, Types::String

    attribute :avatar_url, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
