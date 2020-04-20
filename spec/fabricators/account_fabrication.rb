# frozen_string_literal: true

Fabricator(:account) do
  github 'test'
  name 'Anton'
  email 'test@rubyjobs.dev'

  avatar_url 'https://pbs.twimg.com/media/EWBcj25XYAAfcSQ?format=jpg&name=medium'
end
