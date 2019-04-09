class VacancyRepository < Hanami::Repository
  associations do
    belongs_to :contact
  end

  def all_with_contact
    aggregate(:contact).where(
      deleted_at: nil,
      published: true,
      archived: false
    ).map_to(Vacancy).to_a
  end
end
