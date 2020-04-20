# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    belongs_to :review
    belongs_to :rating
  end

  def find_by_github(data)
    root.where(github: data).map_to(Account).limit(1).one
  end
end
