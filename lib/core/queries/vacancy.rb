# frozen_string_literal: true

module Queries
  class Vacancy
    attr_reader :repo

    def initialize(repo = VacancyRepository.new)
      @repo = repo
    end

    def all_with_contact(limit:, page:, remote_filter: '')
      all_with_contact_relation(limit: limit, page: page, remote_filter: remote_filter).to_a
    end

    def pager_for_all_with_contact(limit:, page:)
      Hanami::Pagination::Pager.new(
        all_with_contact_relation(limit: limit, page: page).pager
      )
    end

    private

    def all_with_contact_relation(limit:, page:, remote_filter:)
      relation = repo.aggregate(:contact)
        .where(published: true, archived: false, deleted_at: nil)
        .map_to(::Vacancy).order { created_at.desc }
        .per_page(limit).page(page || 1)

      if remote_filter == 'only-remote'
        relation = relation.where(remote_available: true)
      elsif remote_filter == 'not-remote'
        relation = relation.where(remote_available: false)
      end

      relation
    end
  end
end
