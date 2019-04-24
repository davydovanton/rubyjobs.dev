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
      end
    end
  end
end
