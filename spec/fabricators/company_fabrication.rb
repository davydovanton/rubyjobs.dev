# frozen_string_literal: true

Fabricator(:company) do
  name 'Google'
  url 'https://google.com'

  rating_total 3.4
  ratings {}
end
