class CompanyRepository < Hanami::Repository
  associations do
    has_many :reviews
  end
end
