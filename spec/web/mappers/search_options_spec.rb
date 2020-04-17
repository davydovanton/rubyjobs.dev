# frozen_string_literal: true

RSpec.describe Web::Mappers::SearchOptions, type: :mapper do
  subject { described_class.new.call(search_options_hash) }

  let(:search_options_hash) { {} }

  it { expect(subject).to be_a(Web::DTO::SearchOptions) }

  context 'when remote is string equaled "true"' do
    let(:search_options_hash) { { remote: 'true', position_type: 'part_time' } }

    it { expect(subject.remote).to eq true }
    it { expect(subject.position_type).to eq 'part_time' }
    it { expect(subject.location).to eq nil }
  end

  context 'when remote is string equaled "false"' do
    let(:search_options_hash) { { remote: 'false', position_type: nil, location: 'New Vasyuki' } }

    it { expect(subject.remote).to eq false }
    it { expect(subject.position_type).to eq nil }
    it { expect(subject.location).to eq 'New Vasyuki' }
  end

  context 'when position_type is invalid' do
    let(:search_options_hash) { { position_type: 'anything' } }

    it do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
