# frozen_string_literal: true

RSpec.describe Web::Mappers::SearchOptions, type: :mapper do
  subject { described_class.new.call(search_options_hash) }

  let(:search_options_hash) { {} }

  it { expect(subject).to be_a(Hash) }

  context 'when remote is string equaled "true"' do
    let(:search_options_hash) { { remote: 'true', position_type: 'part_time' } }

    it { expect(subject[:remote]).to eq true }
    it { expect(subject[:position_type]).to eq 'part_time' }
    it { expect(subject[:location]).to eq nil }
    it { expect(subject[:salary]).to eq nil}
    it { expect(subject[:salary_currency]).to eq nil}
  end

  context 'when remote is string equaled "false"' do
    let(:search_options_hash) { { remote: 'false', position_type: nil, location: 'New Vasyuki' } }

    it { expect(subject[:remote]).to eq false }
    it { expect(subject[:position_type]).to eq nil }
    it { expect(subject[:location]).to eq 'New Vasyuki' }
    it { expect(subject[:salary]).to eq nil}
    it { expect(subject[:salary_currency]).to eq nil}
  end

  context 'when salary is string equaled "545"' do
    let(:search_options_hash) { { remote: nil, position_type: nil, location: nil, salary: '545' } }

    it { expect(subject[:remote]).to eq nil }
    it { expect(subject[:position_type]).to eq nil }
    it { expect(subject[:location]).to eq nil }
    it { expect(subject[:salary]).to eq 545 }
    it { expect(subject[:salary_currency]).to eq nil }
  end

  context 'when salary_currency is string equaled "rub"' do
    let(:search_options_hash) { { remote: nil, position_type: nil, location: nil, salary: nil, salary_currency: 'rub' } }

    it { expect(subject[:remote]).to eq nil }
    it { expect(subject[:position_type]).to eq nil }
    it { expect(subject[:location]).to eq nil }
    it { expect(subject[:salary]).to eq nil }
    it { expect(subject[:salary_currency]).to eq 'rub' }
  end

  context 'when option is invalid' do
    let(:search_options_hash) { { invalid: 'option' } }

    it { expect(subject).to eq({ text: nil, remote: nil, position_type: nil, location: nil, salary: nil, salary_currency: nil }) }
  end
end
