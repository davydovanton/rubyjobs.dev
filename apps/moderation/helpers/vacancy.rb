# frozen_string_literal: true

module Moderation
  module Helpers
    module Vacancy
      def approve_button(id)
        html.form(action: routes.vacancy_approve_path(id), method: 'POST') do
          input(type: 'hidden', name: '_method', value: 'PATCH')
          input(type: 'submit', value: 'Принять', class: 'btn btn-success')
        end
      end

      def disapprove_button(id)
        html.form(action: routes.vacancy_disapprove_path(id), method: 'POST') do
          input(type: 'hidden', name: '_method', value: 'PATCH')
          input(type: 'submit', value: 'Отклонить', class: 'btn btn-warning')
        end
      end

      def company_text(vacancy)
        published_at = RelativeTime.in_words(vacancy.created_at, locale: :ru)
        raw "Компания #{company_link(vacancy)} (#{vacancy.location}), опубликована #{published_at}"
      end

      def company_link(vacancy)
        if vacancy.contact.site
          link_to vacancy.contact.company, vacancy.contact.site
        else
          vacancy.contact.company
        end
      end

      def remote_badge(vacancy)
        return unless vacancy.remote_available

        html.span(class: 'mr-2 badge badge-success') { 'Удаленно' }
      end

      def position_type_badge(vacancy)
        html.span(class: 'mr-2 badge badge-info') { POSITION_TYPE_VALUES[vacancy.position_type] }
      end

      def vacancy_salary_information(vacancy)
        currency = CURRENCY_VALUES[vacancy.salary_currency]
        unit = UNIT_VALUES[vacancy.salary_unit]

        html.span(class: 'salary') do
          text 'от '
          span(class: 'money') { vacancy.salary_min }
          text ' до '
          span(class: 'money') { vacancy.salary_max }
          text " #{currency} #{unit}"
        end
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

      def vacancy_details(vacancy)
        raw_body(vacancy.details)
      end

      def raw_body(body)
        raw(body || '')
      end
    end
  end
end
