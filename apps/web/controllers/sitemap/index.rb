# frozen_string_literal: true

module Web
  module Controllers
    module Sitemap
      class Index
        include Web::Action

        def call(_params)
          self.format = :xml

          sitemap = XmlSitemap::Map.new('https://www.rubyjobs.dev/') do |m|
            m.add '/about', priority: 0.5
            m.add '/contacts', priority: 0.5
            m.add '/terms', priority: 0.5
          end

          self.body = sitemap.render
        end
      end
    end
  end
end
