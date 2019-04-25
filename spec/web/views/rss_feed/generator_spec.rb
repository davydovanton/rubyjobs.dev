# frozen_string_literal: true

RSpec.describe Web::Views::RssFeed::Generator, type: :view do
  subject { view.call(payload) }

  let(:view) { described_class.new(current_time: -> { time }) }
  let(:payload) { { vacancies: [vacancy] } }
  let(:vacancy) { Fabricate.build(:vacancy, published: true, updated_at: time) }
  let(:time) { Time.at(1_556_128_838).utc }

  it 'returns correct rss string' do
    xml_rss = <<~RSS
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom"
        xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>RubyJobs</name>
        </author>
        <id>https://rubyjobs.dev/feed.rss</id>
        <title>Ruby Jobs RSS feed</title>
        <updated>2019-04-24T18:00:38Z</updated>
        <entry>
          <id>https://rubyjobs.dev/vacancies/</id>
          <link href="https://rubyjobs.dev/vacancies/"/>
          <summary>&lt;p&gt;something here&lt;/p&gt;</summary>
          <title>Senior mecha pilot</title>
          <updated>2019-04-24T18:00:38Z</updated>
          <dc:date>2019-04-24T18:00:38Z</dc:date>
        </entry>
        <dc:date>2019-04-24T18:00:38Z</dc:date>
      </feed>
    RSS

    expect("#{subject}\n").to eq(xml_rss)
  end
end
