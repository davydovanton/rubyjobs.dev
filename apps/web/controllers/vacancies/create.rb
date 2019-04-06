module Web
  module Controllers
    module Vacancies
      class Create
        include Web::Action

        def call(params)
          self.body = 'OK'
        end
      end
    end
  end
end
