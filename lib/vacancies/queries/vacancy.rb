# frozen_string_literal: true

module Vacancies
  module Queries
    class Vacancy
      include Import[
        repo: 'repositories.vacancy'
      ]

      EMPTY_HASH = {}.freeze

      def all_with_contact(limit:, page:, search_object: nil)
        all_with_contact_relation(limit: limit, page: page, search_object: search_object || EMPTY_HASH).to_a
      end

      def pager_for_all_with_contact(limit:, page:, search_object: nil)
        Hanami::Pagination::Pager.new(
          all_with_contact_relation(limit: limit, page: page, search_object: search_object || EMPTY_HASH).pager
        )
      end

      private

      QUERY_MODIFIERS = {
        remote: ->(query, filter_value) { query.where(remote_available: filter_value) },
        position_type: ->(query, filter_value) { query.where(position_type: filter_value) },
        location: ->(query, filter_value) { query.where { location.ilike("%#{filter_value}%") } },
        text: lambda do |query, filter_value|
          query.where { position.ilike("%#{filter_value}%") | details_raw.ilike("%#{filter_value}%") }
        end
      }.freeze

      def all_with_contact_relation(limit:, page:, search_object:)
        query = base_query

        search_object.to_h.each do |key, value|
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
