class JobRepository < Hanami::Repository
  associations do
    has_one :contact
  end
end
