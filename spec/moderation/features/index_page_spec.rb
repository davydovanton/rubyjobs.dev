# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /moderation', type: :feature do
  let(:url) { '/moderation' }

  before do
    Fabricate(:vacancy, position: 'Ruby developer')
    Fabricate(:vacancy, position: 'Java developer', published: false)
  end

  it 'returns a index page with all vacancies' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.body).to_not include 'Ruby developer'
    expect(page.body).to include 'Java developer'
  end
end
