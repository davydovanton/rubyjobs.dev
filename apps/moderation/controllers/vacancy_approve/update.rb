# frozen_string_literal: true

module Moderation
  module Controllers
    module VacancyApprove
      class Update
        include Moderation::Action

        def call(_params)
          self.body = 'OK'
        end
      end
    end
  end
end
