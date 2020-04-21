# frozen_string_literal: true

class ReviewRepository < Hanami::Repository
  relations :ratings

  associations do
    has_one :rating

    belongs_to :account, as: :author
    belongs_to :company
  end

  def all_for_companies(company_id)
    aggregate(:author).where(company_id: company_id).map_to(Review).to_a
  end

  def create_with_rating!(payload)
    assoc(:rating).create(payload)
  end
end
