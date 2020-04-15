# frozen_string_literal: true

RSpec.describe Libs::SearchQueryParser do
  let(:parser) { described_class.new }

  it { expect(parser.call(nil)).to eq(text: nil, remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('')).to eq(text: nil, remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('text')).to eq(text: 'text', remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('author:davydovanton')).to eq(author: 'davydovanton', text: nil, remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('tag:test tag:other text')).to eq(tag: %w[test other], text: 'text', remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text', remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call(' author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text', remote: nil, position_type: nil, location: nil) }
  it { expect(parser.call('remote:true location:moscow text')).to eq(text: 'text', remote: 'true', position_type: nil, location: 'moscow') }
end
