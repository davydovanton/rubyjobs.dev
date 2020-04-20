# frozen_string_literal: true

module Web
  module Controllers
    module Reviews
      class Create
        include Web::Action

        def call(_params)
          redirect_to routes.company_path(params[:company_id])
        end
      end
    end
  end
end
