# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    has_many :reviews
    has_many :ratings
    has_many :interviews
    has_many :interview_ratings
  end

  def find_by_github(data)
    root.where(github: data).map_to(Account).limit(1).one
  end
end
