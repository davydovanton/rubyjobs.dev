# typed: false
# frozen_string_literal: true

module Web
  module Helpers
    # simple pagination helper for showing bootstrap pagination block on the index page
    module Pagination
      private

      ONE_PAGGINATION_PAGE = 1

      def pagination(page) # rubocop:disable Metrics/AbcSize
        return if pager.total_pages == ONE_PAGGINATION_PAGE

        html.nav do
          ul(class: 'pagination justify-content-center') do
            content = []

            content << previous_page_tag(page)
            pager.total_pages.times { |page_index| content << page_tag(page, page_index + 1) }
            content << next_page_tag(page)

            raw(content.map(&:to_s).join)
          end
        end
      end

      def previous_page_tag(page)
        disabled = pager.first_page? ? 'disabled' : nil

        html.li(class: "page-item #{disabled}") do
          a(href: previous_page_path(page), class: 'page-link') do
            'Предыдущая'
          end
        end
      end

      def page_tag(page, page_index)
        disabled = page_index == pager.current_page ? 'disabled' : nil

        html.li(class: "page-item #{disabled}") do
          a(href: n_page_path(page, page_index), class: 'page-link') do
            page_index
          end
        end
      end

      def next_page_tag(page)
        disabled = pager.last_page? ? 'disabled' : nil

        html.li(class: "page-item #{disabled}") do
          a(href: next_page_path(page), class: 'page-link') do
            'Следующая'
          end
        end
      end

      def previous_page_path(page)
        routes.path(page, **params, page: pager.prev_page)
      end

      def next_page_path(page)
        routes.path(page, **params, page: pager.next_page)
      end

      def n_page_path(page, n)
        routes.path(page, **params, page: n)
      end
    end
  end
end
