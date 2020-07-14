# frozen_string_literal: true

RSpec.describe Libs::SearchQueryParser do
  let(:parser) { described_class.new }

  it { expect(parser.call(nil)).to eq(text: nil) }
  it { expect(parser.call('')).to eq(text: nil) }
  it { expect(parser.call('text')).to eq(text: 'text') }
  it { expect(parser.call('author:davydovanton')).to eq(author: 'davydovanton', text: nil) }
  it { expect(parser.call('tag:test tag:other text')).to eq(tag: %w[test other], text: 'text') }
  it { expect(parser.call('author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text') }
  it { expect(parser.call(' author:davy lang:ruby text')).to eq(author: 'davy', lang: 'ruby', text: 'text') }
  it { expect(parser.call('remote:true location:moscow text')).to eq(text: 'text', remote: 'true', location: 'moscow') }
  it { expect(parser.call('salary_currency:usd location:Sochi text')).to eq(text: 'text', location: 'Sochi', salary_currency: 'usd') }
  it { expect(parser.call('salary:100 text')).to eq(text: 'text', salary: '100') }
end
