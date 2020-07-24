# frozen_string_literal: true

Fabricator(:interview) do
  company_id { Fabricate.create(:company).id }
  author_id { Fabricate.create(:account).id }

  body_raw 'test'
  body     'test'

  anonymous false
end
