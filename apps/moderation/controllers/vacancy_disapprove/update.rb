module Moderation
  module Controllers
    module VacancyDisapprove
      class Update
        include Moderation::Action

        def call(params)
          self.body = 'OK'
        end
      end
    end
  end
end
