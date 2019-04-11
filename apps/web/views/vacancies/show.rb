module Web
  module Views
    module Vacancies
      class Show
        include Web::View

        def title
          'Вакансия "#{position}"'
        end

        def seo_meta_information
          remote_text = vacancy.remote_available ? 'Возможна удаленная работа. ' : ''

          currency = CURRENCY_VALUES[vacancy.salary_currency]
          unit = UNIT_VALUES[vacancy.salary_unit]
          salary = "от #{vacancy.salary_min} до #{vacancy.salary_max} #{currency} #{unit}"

          {
            title: 'Вакансии для ruby, hanami и rails разработчиков',
            description: "В компании #{vacancy.contact.company} открыта вакансия '#{vacancy.position}'. #{remote_text}Оплата #{salary}.",
            url: "https://rubyjobs.dev/vacancies/#{vacancy.id}",
            image: ''
          }
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
        CURRENCY_VALUES = { 'rub' => 'рублей', 'usd' => 'долларов', 'eur' => 'евро' }
        UNIT_VALUES = { 'monthly' => 'в месяц', 'yearly' => 'в год', 'by hour' => 'в час', 'per project' => 'за проект' }
      end
    end
  end
end
