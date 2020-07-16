# frozen_string_literal: true

class InterviewRatingRepository < Hanami::Repository
  associations do
    has_one :account, as: :author
    belongs_to :interview
  end
end
