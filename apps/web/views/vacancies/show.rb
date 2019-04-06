module Web
  module Views
    module Vacancies
      class Show
        include Web::View

        def title
          'Вакансия "#{position}"'
        end
      end
    end
  end
end
