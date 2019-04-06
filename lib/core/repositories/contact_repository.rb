class ContactRepository < Hanami::Repository
  associations do
    belongs_to :vacancy
  end
end
