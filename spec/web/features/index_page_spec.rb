# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /', type: :feature do
  let(:url) { '/' }

  before do
    Fabricate(:vacancy)
    Fabricate(:vacancy, position: 'Ruby developer')
  end

  it 'responses 200' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.body).to include 'Senior mecha pilot'
    expect(page.body).to include 'Ruby developer'
  end
end
