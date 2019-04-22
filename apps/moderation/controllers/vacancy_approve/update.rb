module Moderation
  module Controllers
    module VacancyApprove
      class Update
        include Moderation::Action

        def call(params)
          self.body = 'OK'
        end
      end
    end
  end
end
