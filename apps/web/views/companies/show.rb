# frozen_string_literal: true

require 'hanami/utils/hash'

module Web
  module Views
    module Companies
      class Show
        include Web::View

        def title
          "Отзыв о компании #{company.name}. Ruby, Hanami и Rails"
        end

        # rubocop:disable Layout/LineLength
        def seo_meta_information
          {
            title: "Отзыв о компании #{company.name}. Ruby, Hanami и Rails",
            description: 'Отзывы о компаниях использующие Ruby по всему миру. Бесплатные условия для работодателей и соискателей.',
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

        def default_rating_names # rubocop:disable Metrics/MethodLength
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

        def company_ratings
          Hanami::Utils::Hash.symbolize(company.ratings)
        end

        def review_author(review)
          if review.anonymous
            'Anonymous author'
          else
            raw "#{review.author.name} (#{link_to review.author.github, "https://github.com/#{review.author.github}"})"
          end
        end

        def published_at(review)
          RelativeTime.in_words(review.created_at, locale: :ru)
        end
      end
    end
  end
end
