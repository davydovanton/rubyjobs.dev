# frozen_string_literal: true

class RatingRepository < Hanami::Repository
  associations do
    has_one :account, as: :author
    has_one :review
  end
end
