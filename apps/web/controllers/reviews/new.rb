# frozen_string_literal: true

module Web
  module Controllers
    module Reviews
      class New
        include Web::Action

        before :authenticate! # run an authentication before callback

        def call(params); end
      end
    end
  end
end
