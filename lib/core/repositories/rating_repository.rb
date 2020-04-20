# frozen_string_literal: true

class RatingRepository < Hanami::Repository
  associations do
    has_one :account, as: :author
    belongs_to :review
  end
end
