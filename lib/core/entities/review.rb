# frozen_string_literal: true

class Account < Hanami::Entity
end

class Review < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :author_id, Types::Int
    attribute :author, Types::Entity(Account)

    attribute :body_raw, Types::String
    attribute :body, Types::String

    attribute :anonymous, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
