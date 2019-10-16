# frozen_string_literal: true

module Moderation
  module Views
    module Dashboard
      class Index
        include Moderation::View
        include Moderation::Helpers::Vacancy
      end
    end
  end
end
