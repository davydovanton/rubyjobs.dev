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

  def all_with_contact(limit:, page:)
    all_with_contact_relation(limit: limit, page: page).to_a
  end

  def pager_for_all_with_contact(limit:, page:)
    Hanami::Pagination::Pager.new(
      all_with_contact_relation(limit: limit, page: page).pager
    )
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

  private

  def all_with_contact_relation(limit:, page:)
    aggregate(:contact)
      .where(published: true, archived: false, deleted_at: nil)
      .map_to(Vacancy).order { created_at.desc }
      .per_page(limit).page(page || 1)
  end
end
