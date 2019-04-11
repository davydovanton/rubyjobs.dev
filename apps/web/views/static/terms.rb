module Web
  module Views
    module Static
      class Terms
        include Web::View

        def title
          'Условия использования сервиса'
        end

        def seo_meta_information
          {
            title: 'Вакансии для ruby, hanami и rails разработчиков',
            description: 'Ruby вакансии от компаний со всего мира, включая возможность удаленной работы. Бесплатные условия для работодателей и соискателей.',
            url: 'https://rubyjobs.dev/terms',
            image: ''
          }
        end
      end
    end
  end
end
