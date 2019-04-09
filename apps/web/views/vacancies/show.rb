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

        def respond_to_email_href
          "mailto:#{vacancy.contact.email}?subject=Резюме на позицию \"#{vacancy.position}\"&body=TODO"
        end

        def raw_body(body)
          raw(body || '')
        end
      end
    end
  end
end
