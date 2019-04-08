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
            div do
              label 'Позиция'
              text_field :position, placeholder: 'Ruby разработчик'

              select :position_type, select_position_type_values, options: { prompt: 'Тип занятости' }
            end

            div do
              label 'Описание вакансии и детали'
              text_area :details_raw, placeholder: 'Для редактирования поддерживается marckdown'
            end

            div do
              label 'Локация'
              text_field :location, placeholder: 'Город, страна'
            end

            div do
              label 'Возможна удаленная работа'
              check_box :remote_available
            end

            fields_for :salary do
              div do
                label 'Вилка'
                text_field :min, placeholder: 'От'
                text_field :max, placeholder: 'До'

                select :currency, select_currency_values, options: { prompt: 'Денежная единица' }
                select :unit, select_unit_values, options: { prompt: 'Период' }
              end
            end

            div do
              label 'Срок размещения'

              radio_button :archived_in_weeks, '2'
              span 'Две недели'

              radio_button :archived_in_weeks, '4'
              span 'Месяц'
            end

            hr

            fields_for :contact do
              div do
                label 'Электронная почта *'
                text_field :email, placeholder: 'hr@company.ru'
              end

              div do
                label 'Контактное лицо *'
                text_field :full_name
              end

              div do
                label 'Компания'
                text_field :company
              end

              div do
                label 'Сайт компании'
                text_field :site
              end
            end


            submit 'Отправить'
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
          { 'в год' => 'yearly', 'в месяц' => 'monthly', 'в час' => 'by hour', 'за проект' => 'per project' }
        end
      end
    end
  end
end
