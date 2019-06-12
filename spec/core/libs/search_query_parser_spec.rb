# frozen_string_literal: true

RSpec.describe Libs::SearchQueryParser do
  let(:parser) { described_class.new }

  it { expect(parser.call('')).to eq(text: nil) }
  it { expect(parser.call('text')).to eq(text: 'text') }
  it { expect(parser.call('author:davydovanton')).to eq(author: 'davydovanton', text: nil) }
  it { expect(parser.call('tag:test tag:other text')).to eq(tag: %w[test other], text: 'text') }
  it { expect(parser.call('author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text') }
  it { expect(parser.call(' author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text') }
end
