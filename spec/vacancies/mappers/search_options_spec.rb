# frozen_string_literal: true

RSpec.describe Vacancies::Mappers::SearchOptions, type: :mapper do
  subject { described_class.new.call(search_options_hash) }

  let(:search_options_hash) { { remote: nil, position_type: 'other', location: 'New Vasyuki' } }

  it { expect(subject).to be_a(Vacancies::Entities::SearchOptions) }
  it { expect(subject.position_type).to eq(search_options_hash[:position_type]) }
  it { expect(subject.location).to eq(search_options_hash[:location]) }

  context 'when remote is string equaled "true"' do
    let(:search_options_hash) { { remote: 'true', position_type: nil, location: nil } }

    it { expect(subject.remote).to be_truthy }
  end
end
