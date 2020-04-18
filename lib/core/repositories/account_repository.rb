class AccountRepository < Hanami::Repository
  associations do
    belongs_to :review
    belongs_to :rating
  end
end
