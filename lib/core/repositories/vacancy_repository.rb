class VacancyRepository < Hanami::Repository
  associations do
    has_one :contact
  end
end
