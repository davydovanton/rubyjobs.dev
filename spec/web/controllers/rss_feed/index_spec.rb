# frozen_string_literal: true

RSpec.describe Web::Controllers::RssFeed::Index, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation, generator: generator) }
  let(:generator) { ->(*) { 'rss' } }
  let(:params) { Hash[] }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(result: [Fabricate.build(:vacancy, published: true, updated_at: Time.now)]) } }

    it { expect(subject).to be_success }
    it { expect(subject).to have_http_status(200) }
    it { expect(subject[2]).to eq(['rss']) }
    it { expect(subject[1]['Content-Type']).to eq('application/xml; charset=utf-8') }
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:something_happened) } }

    it { expect(subject).to have_http_status(422) }
    it { expect(subject[2]).to eq(['Failure']) }
    it { expect(subject[1]['Content-Type']).to eq('application/xml; charset=utf-8') }
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    before do
      12.times { Fabricate.create(:vacancy, published: true, archived: false) }
    end

    it { expect(subject).to be_success }
  end
end
