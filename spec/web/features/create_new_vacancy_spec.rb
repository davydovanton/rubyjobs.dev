# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'GET /vacancies/new', type: :feature do
  let(:url) { '/vacancies/new' }

  context 'when user open new vacancy page' do
    it do
      visit(url)

      expect(page.status_code).to eq 200
    end
  end
end
