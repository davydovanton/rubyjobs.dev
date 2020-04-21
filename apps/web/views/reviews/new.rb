# frozen_string_literal: true

module Web
  module Views
    module Reviews
      class New
        include Web::View

        def title
          'Новый отзыв на компанию - Ruby, Hanami и Rails'
        end

        # rubocop:disable Layout/LineLength
        def seo_meta_information
          {
            title: 'Новый отзыв на компанию - Ruby, Hanami и Rails',
            description: 'Отзывы на компании использующие Ruby по всему миру. Бесплатные условия для работодателей и соискателей.',
            url: "https://rubyjobs.dev/companies/#{params[:company_id]}/reviews/new",
            image: ''
          }
        end
        # rubocop:enable Layout/LineLength

        # rubocop:disable Metrics/AbcSize, Layout/LineLength, Metrics/MethodLength, Metrics/BlockLength
        def form
          form_for :review, routes.company_reviews_path(params[:company_id]), method: :post, class: 'needs-validation', novalidate: true do
            text_field :account_id, type: 'hidden', value: current_account.id

            fields_for :rating do
              rating_names.each do |rating, desctiption|
                div(class: 'form-group') do
                  div(class: 'row') do
                    div(class: 'col-6') do
                      label desctiption
                    end

                    div(class: 'col-6') do
                      select rating, select_rating_values, class: 'custom-select form-control', required: true, options: { selected: 3.0 }
                    end
                  end
                end
              end
            end

            hr(class: 'mb-4 mt-4')

            div(class: 'form-group') do
              div(class: 'col-6 align-items-center') do
                label 'Оставить анонимный отзыв'
                check_box :anonymous
              end
            end

            div(class: 'form-group') do
              text_area :body_raw, placeholder: '', class: 'form-control', rows: 10, required: true

              div(class: 'info') do
                text 'Для редактирования можно использовать '
                a 'markdown', href: 'https://www.markdownguide.org/cheat-sheet', target: '_blank', rel: 'nofollow noopener'
              end
            end

            hr(class: 'mb-4 mt-4')

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
                link_to 'Назад', routes.company_path(params[:company_id]), class: 'btn btn-outline-secondary btn-lg'
              end

              div(class: 'col') do
                submit 'Отправить', class: 'btn btn-success btn-lg'
              end
            end
          end
        end
        # rubocop:enable Metrics/AbcSize, Layout/LineLength, Metrics/MethodLength, Metrics/BlockLength

        private

        def rating_names # rubocop:disable Metrics/MethodLength
          {
            salary_value: 'Материальная компенсация труда в компании',
            office: 'Офис компании',
            working_time: 'График работы',
            project_interest: 'Качество проекта, на котором я работаю',
            atmosphere: 'Рабочая атмосфера, которая царит на проекте',
            personal_growth: 'Возможность профессионального развития которую предоставляет компания',
            modern_technologies: 'Инструменты и технологии использумые в проекте',
            management_level: 'Уровень менеджмента в компании',
            team_level: 'Уровень команды с которой я работаю'
          }
        end

        def select_rating_values
          {
            'Не знаю/Затрудняюсь сказать' => 0.0,
            'Плохо' => 1.0,
            'Бывает хуже' => 2.0,
            'Нормально' => 3.0,
            'Хорошо' => 4.0,
            'Отлично' => 5.0
          }
        end
      end
    end
  end
end
