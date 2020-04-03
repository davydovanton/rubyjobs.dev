# frozen_string_literal: true

module Web
  module Views
    module Static
      class About
        include Web::View

        def title
          'О проекте'
        end

        # rubocop:disable Layout/LineLength
        def seo_meta_information
          {
            title: 'Вакансии для разработчиков Ruby, Hanami и Rails',
            description: 'Вакансии по Ruby от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/about',
            image: ''
          }
        end
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
