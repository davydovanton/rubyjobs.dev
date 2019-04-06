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
              text_field :posititon, placeholder: 'Ruby разработчик'
            end

            div do
              label 'Описание вакансии и детали'
              text_field :details_raw, placeholder: 'Для редактирования поддерживается marckdown'
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
                text_field :from, placeholder: 'От'
                text_field :to, placeholder: 'До'
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
      end
    end
  end
end
