# frozen_string_literal: true

Fabricator(:vacancy) do
  contact_id { Fabricate.create(:contact).id }

  position 'Senior mecha pilot'
  position_type 'full_time'

  details_raw 'something here'
  details '<p>something here</p>'

  location 'moscow'
  remote_available false

  published true
  archived false

  salary_min 100_000
  salary_max 150_000
  salary_currency 'rub'
  salary_unit 'monthly'

  # archive it after 2 weeks
  archived_at { (Time.now + 2 * (60 * 60 * 24 * 7)).to_date }
end
