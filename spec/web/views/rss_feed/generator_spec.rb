# frozen_string_literal: true

require 'rss'

RSpec.describe Web::Views::RssFeed::Generator, type: :view do
  subject { RSS::Parser.parse(view.call(payload)) }

  let(:view) { described_class.new(current_time: -> { time }) }
  let(:payload) { { vacancies: [vacancy] } }
  let(:vacancy) { Fabricate.build(:vacancy, published: true, updated_at: time) }
  let(:time) { Time.at(1_556_128_838).utc }

  it { expect(subject.author.name.content).to eq 'RubyJobs' }
  it { expect(subject.title.content).to eq 'Ruby Jobs RSS feed' }
  it { expect(subject.id.content).to eq 'https://rubyjobs.dev/feed.rss' }
  it { expect(subject.updated.content).to eq time }
  it { expect(subject.date).to eq time }

  it { expect(subject.entries.size).to eq 1 }
  it { expect(subject.entries[0].id.content).to eq "https://rubyjobs.dev/vacancies/#{vacancy.id}" }
  it { expect(subject.entries[0].link.href).to eq "https://rubyjobs.dev/vacancies/#{vacancy.id}" }
  it { expect(subject.entries[0].summary.content).to eq vacancy.details }
  it { expect(subject.entries[0].title.content).to eq vacancy.position }
  it { expect(subject.entries[0].updated.content).to eq time }
  it { expect(subject.entries[0].date).to eq time }
end
