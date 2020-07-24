# frozen_string_literal: true

class Review < Hanami::Entity
end

class Interview < Hanami::Entity
end

class Company < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :reviews, Types::Collection(Review)
    attribute :interviews, Types::Collection(Interview)

    attribute :name, Types::String
    attribute :url, Types::String

    attribute :rating_total, Types::Float
    attribute :ratings, Core::Types::CompanyRatings
    attribute :interview_rating_total, Types::Float
    attribute :interview_ratings, Core::Types::CompanyRatings

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
