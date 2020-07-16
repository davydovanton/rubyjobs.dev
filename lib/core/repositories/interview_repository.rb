# frozen_string_literal: true

class InterviewRepository < Hanami::Repository
  relations :interview_ratings

  associations do
    has_one :interview_rating

    belongs_to :account, as: :author
    belongs_to :company
  end

  def all_for_companies(company_id)
    aggregate(:author).where(company_id: company_id).map_to(Interview).order { created_at.desc }.to_a
  end

  def create_with_interview_rating!(payload)
    assoc(:interview_rating).create(payload)
  end
end
