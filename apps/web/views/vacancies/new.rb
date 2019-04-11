# frozen_string_literal: true

module Web
  module Views
    module Vacancies
      class New # rubocop:disable Metrics/ClassLength
        include Web::View

        def title
          'Новая вакансия'
        end

        # rubocop:disable Metrics/LineLength
        def seo_meta_information
          {
            title: 'Новая вакансия - rubyjobs.dev',
            description: 'Ruby вакансии от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/vacancies/new',
            image: ''
          }
        end
        # rubocop:enable Metrics/LineLength

        # rubocop:disable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength, Metrics/BlockLength
        def form
          form_for :vacancy, routes.vacancies_path, method: :post, class: 'needs-validation', novalidate: true do
            div(class: 'form-group') do
              label 'Позиция *'
              div(class: 'row') do
                div(class: 'col-8') do
                  text_field :position, placeholder: 'Ruby разработчик', class: 'form-control', required: true
                end

                div(class: 'col-4') do
                  select :position_type, select_position_type_values, class: 'custom-select form-control', required: true
                end
              end
            end

            div(class: 'form-group') do
              label 'Описание вакансии и детали *'
              text_area :details_raw, placeholder: '', class: 'form-control', rows: 15, required: true

              div(class: 'info') do
                text 'Для редактирования можно использовть '
                a 'markdown', href: 'https://www.markdownguide.org/cheat-sheet'
              end
            end

            div(class: 'form-group') do
              div(class: 'row') do
                div(class: 'col') do
                  label 'Локация *'
                end
              end

              div(class: 'row') do
                div(class: 'col-4') do
                  text_field :location, placeholder: 'Город, страна', class: 'form-control', required: true
                end

                div(class: 'col-6 align-items-center') do
                  label 'Возможна удаленная работа'
                  check_box :remote_available
                end
              end
            end

            fields_for :salary do
              div(class: 'form-group') do
                div(class: 'row') do
                  div(class: 'col') do
                    label 'Вилка *'
                  end
                end

                div(class: 'row') do
                  div(class: 'col-3') do
                    text_field :min, placeholder: 'От', class: 'form-control', required: true
                  end
                  div(class: 'col-3') do
                    text_field :max, placeholder: 'До', class: 'form-control', required: true
                  end

                  div(class: 'col-3') do
                    select :currency, select_currency_values, class: 'custom-select form-control', required: true
                  end
                  div(class: 'col-3') do
                    select :unit, select_unit_values, class: 'form-control custom-select', required: true
                  end
                end
              end
            end

            div(class: 'form-group') do
              div(class: 'row') do
                div(class: 'col-3') do
                  label 'Срок размещения'
                end

                div(class: 'col-4') do
                  radio_button :archived_in_weeks, '2', checked: true
                  span 'Две недели'
                end
              end

              div(class: 'row') do
                div(class: 'col-3') do
                end
                div(class: 'col-4') do
                  radio_button :archived_in_weeks, '4'
                  span 'Месяц'
                end
              end
            end

            hr(class: 'mb-4 mt-4')

            fields_for :contact do
              div(class: 'form-group') do
                label 'Электронная почта *'
                text_field :email, placeholder: 'hr@company.ru', class: 'form-control', required: true
              end

              div(class: 'form-group') do
                label 'Контактное лицо *'
                text_field :full_name, class: 'form-control', required: true
              end

              div(class: 'form-group') do
                label 'Компания *'
                text_field :company, class: 'form-control', required: true
              end

              div(class: 'form-group') do
                label 'Сайт компании'
                text_field :site, class: 'form-control'
              end
            end

            div(class: 'row mt-4') do
              div(class: 'col') do
                div(class: 'alert alert-primary') do
                  text('Отправляя эту форму, вы автоматически соглашаетесь с ')
                  a 'условиями работы сервиса.', href: routes.terms_path
                end
              end
            end

            div(class: 'row mt-4') do
              div(class: 'col') do
                link_to 'На главную', routes.root_path, class: 'btn btn-outline-secondary btn-lg'
              end

              div(class: 'col') do
                submit 'Отправить', class: 'btn btn-success btn-lg'
              end
            end
          end
        end
        # rubocop:enable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength, Metrics/BlockLength

        private

        def select_position_type_values
          {
            'Тип занятости...' => '',
            'Полная занятость' => 'full_time',
            'Частичная занятость' => 'part_time',
            'Работа по контракту' => 'contractor',
            'Интернатура' => 'intern',
            'Временная работа' => 'temp',
            'Другое' => 'other'
          }
        end

        def select_currency_values
          { 'Денежная единица...' => '', 'рублей' => 'rub', 'долларов' => 'usd', 'евро' => 'eur' }
        end

        def select_unit_values
          {
            'Период...' => '',
            'в месяц' => 'monthly',
            'в год' => 'yearly',
            'в час' => 'by hour',
            'за проект' => 'per project'
          }
        end
      end
    end
  end
end
