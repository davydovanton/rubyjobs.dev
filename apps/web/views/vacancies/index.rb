module Web
  module Views
    module Vacancies
      class Index
        include Web::View

        def title
          'Вакансии для ruby, hanami и rails разработчиков'
        end

        def seo_meta_information
          {
            title: 'Вакансии для ruby, hanami и rails разработчиков',
            description: 'Ruby вакансии от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev',
            image: ''
          }
        end
      end
    end
  end
end
