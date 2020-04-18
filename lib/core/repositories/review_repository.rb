class ReviewRepository < Hanami::Repository
  associations do
    belongs_to :company
    belongs_to :rating

    has_one :account, as: :author
  end
end
