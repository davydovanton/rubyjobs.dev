module Web
  module Views
    module Static
      class About
        include Web::View

        def title
          'О проекте'
        end
      end
    end
  end
end
