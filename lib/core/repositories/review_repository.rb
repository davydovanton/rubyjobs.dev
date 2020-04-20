# frozen_string_literal: true

class ReviewRepository < Hanami::Repository
  relations :ratings

  associations do
    belongs_to :company
    has_one :rating

    has_one :account, as: :author
  end

  def create_with_rating!(payload)
    assoc(:rating).create(payload)
  end
end
