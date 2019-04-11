module Web
  module Views
    module Static
      class About
        include Web::View

        def title
          'О проекте'
        end

        def seo_meta_information
          {
            title: 'Вакансии для ruby, hanami и rails разработчиков',
            description: 'Ruby вакансии от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/about',
            image: ''
          }
        end
      end
    end
  end
end
