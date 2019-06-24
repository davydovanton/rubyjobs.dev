# frozen_string_literal: true

module Queries
  class Vacancy
    attr_reader :repo

    def initialize(repo = VacancyRepository.new)
      @repo = repo
    end

    def all_with_contact(limit:, page:, search_query:)
      all_with_contact_relation(limit: limit, page: page, search_query: search_query).to_a
    end

    def pager_for_all_with_contact(limit:, page:, search_query:)
      Hanami::Pagination::Pager.new(
        all_with_contact_relation(limit: limit, page: page, search_query: search_query).pager
      )
    end

    private

    QUERY_MODIFIERS = {
      remote: ->(query, filter_value) { query.where(remote_available: filter_value) },
      position_type: ->(query, filter_value) { query.where(position_type: filter_value) },
      location: ->(query, filter_value) { query.where { location.ilike("%#{filter_value}%") } }
    }.freeze

    def all_with_contact_relation(limit:, page:, search_query:)
      query = repo.aggregate(:contact)
                  .where(published: true, archived: false, deleted_at: nil)
      search_query.each do |key, value|
        modifier = QUERY_MODIFIERS[key] || ->(initial_query, _filter_value) { initial_query }
        query = modifier.call(query, value)
      end
      query.map_to(::Vacancy).order { created_at.desc }
           .per_page(limit).page(page || 1)
    end
  end
end
