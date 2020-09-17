# frozen_string_literal: true

module Web
  module Views
    module Companies
      class Index
        include Web::View

        def title
          'Отзывы о компаниях Ruby, Hanami и Rails'
        end

        # rubocop:disable Layout/LineLength
        def seo_meta_information
          {
            title: 'Отзывы о компаниях Ruby, Hanami и Rails',
            description: 'Отзывы о компаниях использующие Ruby по всему миру. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/companies',
            image: ''
          }
        end
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
