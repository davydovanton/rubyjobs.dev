# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    belongs_to :review
    belongs_to :rating
  end
end
