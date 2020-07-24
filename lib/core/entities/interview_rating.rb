# frozen_string_literal: true

class Account < Hanami::Entity
end

class Interview < Hanami::Entity
end

class InterviewRating < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :author_id, Types::Int
    attribute :author, Types::Entity(Account)

    attribute :interview_id, Types::Int
    attribute :interview, Types::Entity(Interview)

    attribute :overall_impression, Types::Float
    attribute :recommendation, Types::Float

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
