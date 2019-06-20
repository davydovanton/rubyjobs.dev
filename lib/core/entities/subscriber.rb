# typed: ignore
# frozen_string_literal: true

class Subscriber < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :email, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
