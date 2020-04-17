# frozen_string_literal: true

module Vacancies
  module Queries
    class Vacancy
      EMPTY_HASH = {}.freeze

      attr_reader :repo

      def initialize(repo = VacancyRepository.new)
        @repo = repo
      end

      def all_with_contact(limit:, page:, search_query: nil)
        all_with_contact_relation(limit: limit, page: page, search_query: search_query || EMPTY_HASH).to_a
      end

      def pager_for_all_with_contact(limit:, page:, search_query: nil)
        Hanami::Pagination::Pager.new(
          all_with_contact_relation(limit: limit, page: page, search_query: search_query || EMPTY_HASH).pager
        )
      end

    private

      QUERY_MODIFIERS = {
        remote: ->(query, filter_value) { query.where(remote_available: filter_value) },
        position_type: ->(query, filter_value) { query.where(position_type: filter_value) },
        location: ->(query, filter_value) { query.where { location.ilike("%#{filter_value}%") } }
      }.freeze

      def all_with_contact_relation(limit:, page:, search_query:)
        query = base_query

        search_query.to_h.each do |key, value|
          next if value.nil?

          modifier = QUERY_MODIFIERS[key]
          query = modifier.call(query, value) if modifier
        end

        query.per_page(limit).page(page || 1)
      end

      def base_query
        repo.aggregate(:contact)
          .where(published: true, archived: false, deleted_at: nil)
          .where('archived_at > ?', Date.today)
          .map_to(::Vacancy).order { created_at.desc }
      end
    end
  end
end
