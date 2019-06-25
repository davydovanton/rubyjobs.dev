# frozen_string_literal: true

module Web
  module Views
    module Vacancies
      class Index
        include Web::View
        include Web::Helpers::Pagination

        def title
          'Вакансии для разработчиков Ruby, Hanami и Rails'
        end

        # rubocop:disable Metrics/LineLength
        def seo_meta_information
          {
            title: 'Вакансии для разработчиков Ruby, Hanami и Rails',
            description: 'Вакансии по Ruby от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev',
            image: ''
          }
        end
        # rubocop:enable Metrics/LineLength

        def subscribe_form # rubocop:disable Metrics/MethodLength
          form_for :subscriber, routes.subscribers_path, method: :post, class: 'needs-validation', novalidate: true do
            div(class: 'form-group') do
              div(class: 'row') do
                div(class: 'col-8') do
                  text_field :email, placeholder: 'Email адресс', class: 'form-control', required: true
                end

                div(class: 'col-4') do
                  submit 'Отправить', class: 'btn btn-success btn-lg'
                end
              end
            end
          end
        end

        def remote_filter_button(text:, remote_value:)
          link_params =
            if remote_value == current_remote_query
              { class: 'btn btn-light active' }
            else
              { class: 'btn btn-light', href: remote_filter_button_href(remote_value) }
            end

          html.a(link_params) do
            html.input(type: 'radio')
            html.span { text }
          end
        end

        private

        def current_remote_query
          search_query[:remote] if search_query[:remote] == 'true' || search_query[:remote] == 'false'
        end

        def remote_filter_button_href(remote_value)
          routes.root_path(remote_value.nil? ? {} : { query: "remote:#{remote_value}" })
        end
      end
    end
  end
end
