class ContactRepository < Hanami::Repository
  associations do
    has_one :vacancy
  end
end
