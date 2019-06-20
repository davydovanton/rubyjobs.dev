# typed: ignore
# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def vacancy_information(vacancy, analitics = nil)
        published_at = RelativeTime.in_words(vacancy.created_at, locale: :ru)
        analitics_information = analitics && ", #{analitics.view_count} 👀"

        # rubocop:disable Metrics/LineLength
        raw "Компания #{company_link(vacancy)} (#{vacancy.location}), опубликована #{published_at}#{analitics_information}"
        # rubocop:enable Metrics/LineLength
      end

      def company_link(vacancy)
        if vacancy.contact.site
          html.a(
            vacancy.contact.company,
            href: add_url_schema(vacancy.contact.site),
            title: "Сайт компании #{vacancy.contact.company}",
            target: '_blank'
          )
        else
          vacancy.contact.company
        end
      end

      def remote_badge(vacancy)
        return unless vacancy.remote_available

        html.span(class: 'mr-2 badge badge-success') { 'Удалённая работа' }
      end

      def position_type_badge(vacancy)
        html.span(class: 'mr-2 badge badge-info') { POSITION_TYPE_VALUES[vacancy.position_type] }
      end

      def tag_badges(tags)
        return if tags.empty?

        html.div(class: 'row') do
          div(class: 'col-sm-8') do
            tags.each do |tag|
              a(href: '#', class: 'badge badge-primary') { tag }
            end
          end
        end
      end

      def vacancy_salary_information(vacancy) # rubocop:disable Metrics/AbcSize
        currency = CURRENCY_VALUES[vacancy.salary_currency]
        unit = UNIT_VALUES[vacancy.salary_unit]

        html.span(class: 'salary') do
          text 'от '
          span(class: 'money') { round_price(vacancy.salary_min) }
          text ' до '
          span(class: 'money') { round_price(vacancy.salary_max) }
          text " #{currency} #{unit}"
        end
      end

      def round_price(price)
        return nil unless price
        return price if price.to_s.size <= 3

        price.to_s.reverse.gsub!(/(\d{3})(?=\d)/, '\\1 ').reverse
      end

      POSITION_TYPE_VALUES = {
        'full_time' => 'Полная занятость',
        'part_time' => 'Частичная занятость',
        'contractor' => 'Работа по контракту',
        'intern' => 'Интернатура',
        'temp' => 'Временная работа',
        'other' => 'Другое'
      }.freeze

      CURRENCY_VALUES = { 'rub' => 'рублей', 'usd' => 'долларов', 'eur' => 'евро' }.freeze

      UNIT_VALUES = {
        'monthly' => 'в месяц',
        'yearly' => 'в год',
        'by hour' => 'в час',
        'per project' => 'за проект'
      }.freeze
    end
  end
end
