# frozen_string_literal: true

module Moderation
  module Controllers
    module VacancyDisapprove
      class Update
        include Moderation::Action

        def call(_params)
          self.body = 'OK'
        end
      end
    end
  end
end
