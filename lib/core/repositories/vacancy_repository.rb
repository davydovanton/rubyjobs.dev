# frozen_string_literal: true

class VacancyRepository < Hanami::Repository
  associations do
    belongs_to :contact
  end

  def archive_for_today
    root.where(archived_at: Date.today).update(archived: true)
  end

  def all_with_contact
    aggregate(:contact).where(
      published: true,
      archived: false,
      deleted_at: nil
    ).map_to(Vacancy).order { created_at.desc }.to_a
  end

  def all_for_moderation
    aggregate(:contact).where(
      published: false,
      archived: false,
      deleted_at: nil
    ).map_to(Vacancy).to_a
  end

  def find_with_contact(id)
    aggregate(:contact).where(
      published: true,
      archived: false,
      deleted_at: nil
    ).by_pk(id).map_to(Vacancy).one
  end
end
