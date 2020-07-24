module Web
  module Views
    module Interviews
      class Index
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

        def default_rating_names # rubocop:disable Metrics/MethodLength
          {
            overall_impression: 'Общее впечатление',
            recommendation: 'Рекомендация друзьям'
          }
        end

        def interview_author(interview)
          if interview.anonymous
            'Anonymous author'
          else
            raw "#{interview.author.name} (#{link_to interview.author.github, "https://github.com/#{interview.author.github}"})"
          end
        end

        def published_at(interview)
          RelativeTime.in_words(interview.created_at, locale: :ru)
        end

        def company_interview_ratings
          Hanami::Utils::Hash.symbolize(company.interview_ratings)
        end

        def company_information(company)
          # last_rating_time = RelativeTime.in_words(company.created_at, locale: :ru)
          company_link = link_to company.name, company.url

          raw "Компания #{company_link}, рейтинг #{company.rating_total.rou}"
        end
      end
    end
  end
end
