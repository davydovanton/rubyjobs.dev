# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'User can subscribe to weekly emails', type: :feature do
  let(:url) { '' }
  let(:repo) { SubscriberRepository.new }

  xit 'creates a new subscriber object' do
    visit(url)
    expect(page.status_code).to eq 200
  end
end
