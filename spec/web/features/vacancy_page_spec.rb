# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /vacancies/:id', type: :feature do
  let(:url) { "/vacancies/#{vacancy.id}" }
  let(:vacancy) { Fabricate(:vacancy, position: 'Ruby developer') }

  before { vacancy && Fabricate(:vacancy) }

  it 'returns vacancy page with all information about vacancy' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.body).to include 'Ruby developer'
  end
end
