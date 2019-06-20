# typed: false
# frozen_string_literal: true

Fabricator(:contact) do
  key 'test-toggle'
  name 'toggle for testing'
  description 'default test toggle for specs'
  type 'boolean'
  status 'enable'

  email 'hr@company.com'
  full_name 'Shinji Ikari'
  company 'NERV'
end
