# typed: ignore
# frozen_string_literal: true

module Queries
  class Vacancy
    attr_reader :repo

    def initialize(repo = VacancyRepository.new)
      @repo = repo
    end

    def all_with_contact(limit:, page:)
      all_with_contact_relation(limit: limit, page: page).to_a
    end

    def pager_for_all_with_contact(limit:, page:)
      Hanami::Pagination::Pager.new(
        all_with_contact_relation(limit: limit, page: page).pager
      )
    end

    private

    def all_with_contact_relation(limit:, page:)
      repo.aggregate(:contact)
          .where(published: true, archived: false, deleted_at: nil)
          .map_to(::Vacancy).order { created_at.desc }
          .per_page(limit).page(page || 1)
    end
  end
end
