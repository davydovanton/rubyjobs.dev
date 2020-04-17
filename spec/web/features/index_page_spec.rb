# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /', type: :feature do
  let(:url) { '/' }

  before do
    Fabricate(:vacancy)
    Fabricate(:vacancy, position: 'Ruby developer')
    Fabricate(:vacancy, position: 'Java developer', published: false)
    Fabricate(:vacancy, position: 'C# developer',   remote_available: true)
  end

  it 'returns a index page with all vacancies' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.body).to include 'Senior mecha pilot'
    expect(page.body).to include 'Ruby developer'
    expect(page.body).to include 'C# developer'

    expect(page.body).to_not include 'Java developer'
  end

  context 'with remote:true query parameter' do
    let(:url) { '/?query=remote:true' }

    it 'returns a index page with all vacancies' do
      visit(url)

      expect(page.status_code).to eq 200
      expect(page.body).to include 'C# developer'

      expect(page.body).to_not include 'Senior mecha pilot'
      expect(page.body).to_not include 'Ruby developer'
      expect(page.body).to_not include 'Java developer'
    end
  end

  context 'with remote:false query parameter' do
    let(:url) { '/?query=remote:false Ruby' }

    it 'returns a index page with all vacancies' do
      visit(url)

      expect(page.status_code).to eq 200
      expect(page.body).to_not include 'C# developer'
      expect(page.body).to_not include 'Java developer'
      expect(page.body).to_not include 'Senior mecha pilot'

      expect(page.body).to include 'Ruby developer'
    end
  end
end
