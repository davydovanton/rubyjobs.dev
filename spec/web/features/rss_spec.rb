# typed: ignore
# frozen_string_literal: true

require 'features_helper'
require 'rss'

RSpec.describe 'GET /', type: :feature do
  let(:url) { '/feed.rss' }

  let!(:first_developer) { Fabricate(:vacancy) }
  let!(:second_developer) { Fabricate(:vacancy, position: 'Ruby developer') }
  let!(:unpublished_developer) { Fabricate(:vacancy, position: 'Java developer', published: false) }

  it 'returns a rss feed with all vacancies' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.response_headers['Content-Type']).to eq 'application/xml; charset=utf-8'

    feed = RSS::Parser.parse(page.body)

    expect(feed.author.name.content).to eq 'RubyJobs'
    expect(feed.title.content).to eq 'Ruby Jobs RSS feed'
    expect(feed.id.content).to eq 'https://rubyjobs.dev/feed.rss'

    expect(feed.entries.size).to eq 2

    expect(feed.entries[0].id.content).to eq "https://rubyjobs.dev/vacancies/#{second_developer.id}"
    expect(feed.entries[0].link.href).to eq "https://rubyjobs.dev/vacancies/#{second_developer.id}"
    expect(feed.entries[0].summary.content).to eq second_developer.details
    expect(feed.entries[0].title.content).to eq second_developer.position
    expect(feed.entries[0].updated.content).to eq Time.at(second_developer.updated_at.to_i)
    expect(feed.entries[0].date).to eq Time.at(second_developer.updated_at.to_i)

    expect(feed.entries[1].id.content).to eq "https://rubyjobs.dev/vacancies/#{first_developer.id}"
    expect(feed.entries[1].link.href).to eq "https://rubyjobs.dev/vacancies/#{first_developer.id}"
    expect(feed.entries[1].summary.content).to eq first_developer.details
    expect(feed.entries[1].title.content).to eq first_developer.position
    expect(feed.entries[1].updated.content).to eq Time.at(first_developer.updated_at.to_i)
    expect(feed.entries[1].date).to eq Time.at(first_developer.updated_at.to_i)
  end
end
