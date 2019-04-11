# frozen_string_literal: true

module Moderation
  module Views
    module Dashboard
      class Index
        include Moderation::View

        def vacancy_details(vacancy)
          raw_body(vacancy.details)
        end

        def raw_body(body)
          raw(body || '')
        end
      end
    end
  end
end
