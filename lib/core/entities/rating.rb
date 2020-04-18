class Account < Hanami::Entity
end

class Review < Hanami::Entity
end

class Rating < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :author_id, Types::Int
    attribute :author, Types::Entity(Account)

    attribute :review_id, Types::Int
    attribute :review, Types::Entity(Review)

    attribute :salary_value,        Types::Float
    attribute :office,              Types::Float
    attribute :working_time,        Types::Float
    attribute :managment_level,     Types::Float
    attribute :project_interest,    Types::Float
    attribute :atmosphere,          Types::Float
    attribute :personal_growth,     Types::Float
    attribute :modern_technologies, Types::Float

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
