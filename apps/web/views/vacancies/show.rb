module Web
  module Views
    module Vacancies
      class Show
        include Web::View

        def title
          'Вакансия "#{position}"'
        end

        def vacancy_details
          raw_body(vacancy.details)
        end

      private

        def raw_body(body)
          raw(body || '')
        end
      end
    end
  end
end
