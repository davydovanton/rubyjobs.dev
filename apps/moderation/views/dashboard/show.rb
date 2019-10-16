# frozen_string_literal: true

module Moderation
  module Views
    module Dashboard
      class Show
        include Moderation::View
        include Moderation::Helpers::Vacancy
      end
    end
  end
end
