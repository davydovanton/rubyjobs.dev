# frozen_string_literal: true

module Web
  module Views
    module Companies
      class Show
        include Web::View

        def title
          'Отзывы на компании Ruby, Hanami и Rails'
        end

        # rubocop:disable Layout/LineLength
        def seo_meta_information
          {
            title: 'Отзывы на компании Ruby, Hanami и Rails',
            description: 'Отзывы на компании использующие Ruby по всему миру. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/companies',
            image: ''
          }
        end
        # rubocop:enable Layout/LineLength

        def company_information(company)
          # last_rating_time = RelativeTime.in_words(company.created_at, locale: :ru)
          company_link = link_to company.name, company.url

          raw "Компания #{company_link}, рейтинг #{company.rating_total}"
        end
      end
    end
  end
end
