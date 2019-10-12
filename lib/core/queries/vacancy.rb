# frozen_string_literal: true

module Queries
  class Vacancy
    attr_reader :repo

    def initialize(repo = VacancyRepository.new)
      @repo = repo
    end

    def all_with_contact(limit:, page:, remote_available: nil)
      all_with_contact_relation(limit: limit, page: page, remote_available: remote_available).to_a
    end

    def pager_for_all_with_contact(limit:, page:, remote_available: nil)
      Hanami::Pagination::Pager.new(
        all_with_contact_relation(limit: limit, page: page, remote_available: remote_available).pager
      )
    end

    private

    def all_with_contact_relation(limit:, page:, remote_available:)
      relation = repo.aggregate(:contact)
                     .where(published: true, archived: false, deleted_at: nil)
                     .map_to(::Vacancy).order { created_at.desc }
                     .per_page(limit).page(page || 1)

      unless remote_available.nil?
        relation = relation.where(remote_available: remote_available)
      end

      relation
    end
  end
end
