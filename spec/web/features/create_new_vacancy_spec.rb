# typed: false
# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /vacancies/new', type: :feature do
  let(:url) { '/vacancies/new' }

  xit 'creates a new vacancy' do
    visit(url)

    expect(page.status_code).to eq 200
  end
end
