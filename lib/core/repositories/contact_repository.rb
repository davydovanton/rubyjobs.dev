class ContactRepository < Hanami::Repository
  associations do
    belongs_to :job
  end
end
