# frozen_string_literal: true

class VacancyRepository < Hanami::Repository
  associations do
    belongs_to :contact
    has_one :vacancy_analitic
  end

  def archive_for_today
    root.where(archived_at: Date.today).update(archived: true)
  end

  def approve_by_pk(id)
    root.by_pk(id).update(published: true)
  end

  def disapprove_by_pk(id)
    root.by_pk(id).update(deleted_at: Time.now)
  end

  def all_for_moderation
    for_modertion.map_to(Vacancy).to_a
  end

  def find_for_moderation(id)
    for_modertion.by_pk(id).map_to(Vacancy).one
  end

  def find_with_contact(id)
    aggregate(:contact).where(
      published: true,
      archived: false,
      deleted_at: nil
    ).by_pk(id).map_to(Vacancy).one
  end

  private

  def for_modertion
    aggregate(:contact).where(
      published: false,
      archived: false,
      deleted_at: nil
    )
  end
end
