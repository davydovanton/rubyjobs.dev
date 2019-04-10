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
          body = <<~HEREDOC
            Привет!#{NEW_LINE_IN_EMAIL_BODY}
            Увидел вакансию на rubyjobs.dev
          HEREDOC

          "mailto:#{vacancy.contact.email}?subject=Резюме на позицию \"#{vacancy.position}\"&body=#{body}"
        end

        def raw_body(body)
          raw(body || '')
        end

      private

        NEW_LINE_IN_EMAIL_BODY = '%0D%0A'
      end
    end
  end
end
