# frozen_string_literal: true

class VacancyRepository < Hanami::Repository
  associations do
    belongs_to :contact
    has_one :vacancy_analitic
  end

  def approve_by_pk(id)
    root.by_pk(id).update(published: true)
  end

  def disapprove_by_pk(id)
    root.by_pk(id).update(deleted_at: Time.now)
  end

  def all_for_moderation
    aggregate(:contact)
      .where(published: false, deleted_at: nil)
      .where('archived_at > ?', Date.today)
      .map_to(Vacancy).to_a
  end

  def find_with_contact(id)
    aggregate(:contact)
      .where(published: true, deleted_at: nil)
      .where('archived_at > ?', Date.today)
      .by_pk(id).map_to(Vacancy).one
  end

  def archive_for_today
    root.where(archived_at: Date.today).update(archived: true)
  end
end
