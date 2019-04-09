module Web
  module Views
    module Vacancies
      class New
        include Web::View

        def title
          'Новая вакансия'
        end

        def form
          form_for :vacancy, routes.vacancies_path, method: :post do
            div(class: 'form-group') do
              label 'Позиция'
              div(class: 'row') do
                div(class: 'col-8') do
                  text_field :position, placeholder: 'Ruby разработчик', class: 'form-control'
                end

                div(class: 'col-4') do
                  select :position_type, select_position_type_values, options: { prompt: 'Тип занятости' }, class: 'form-control'
                end
              end
            end

            div(class: 'form-group') do
              label 'Описание вакансии и детали'
              text_area :details_raw, placeholder: 'Для редактирования поддерживается marckdown', class: 'form-control'
            end

            div(class: 'form-group') do
              div(class: 'row') do
                div(class: 'col') do
                  label 'Локация'
                end
              end

              div(class: 'row') do
                div(class: 'col-4') do
                  text_field :location, placeholder: 'Город, страна', class: 'form-control'
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
                    label 'Вилка'
                  end
                end

                div(class: 'row') do
                  div(class: 'col-3') do
                    text_field :min, placeholder: 'От', class: 'form-control'
                  end
                  div(class: 'col-3') do
                    text_field :max, placeholder: 'До', class: 'form-control'
                  end

                  div(class: 'col-3') do
                    select :currency, select_currency_values, options: { prompt: 'Денежная единица' }, class: 'form-control'
                  end
                  div(class: 'col-3') do
                    select :unit, select_unit_values, options: { prompt: 'Период' }, class: 'form-control'
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
                  radio_button :archived_in_weeks, '2'
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
                text_field :email, placeholder: 'hr@company.ru', class: 'form-control'
              end

              div(class: 'form-group') do
                label 'Контактное лицо *'
                text_field :full_name, class: 'form-control'
              end

              div(class: 'form-group') do
                label 'Компания'
                text_field :company, class: 'form-control'
              end

              div(class: 'form-group') do
                label 'Сайт компании'
                text_field :site, class: 'form-control'
              end
            end

            div(class: 'row mt-4') do
              div(class: 'col') do
                div(class: 'alert alert-primary') do
                  text("Отправляя эту форму, вы автоматически соглашаетесь с ")
                  a 'условиями работы сервиса.', href: routes.terms_path
                end
              end
            end

            div(class: 'row mt-4') do
              div(class: 'col') do
                link_to 'На главную', routes.root_path, class: 'btn btn-outline-secondary'
              end

              div(class: 'col') do
                submit 'Отправить', class: 'btn btn-success'
              end
            end
          end
        end

      private

        def select_position_type_values
          {
            'Полная занятость' => 'full_time',
            'Частичная занятость' => 'part_time',
            'Работа по контракту' => 'contractor',
            'Интернатура' => 'intern',
            'Временная работа' => 'temp',
            'Другое' => 'other'
          }
        end

        def select_currency_values
          { 'рублей' => 'rub', 'долларов' => 'usd', 'евро' => 'eur' }
        end

        def select_unit_values
          { 'в месяц' => 'monthly', 'в год' => 'yearly', 'в час' => 'by hour', 'за проект' => 'per project' }
        end
      end
    end
  end
end
