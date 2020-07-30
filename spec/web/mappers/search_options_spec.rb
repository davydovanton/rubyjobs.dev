# frozen_string_literal: true

RSpec.describe Web::Mappers::SearchOptions, type: :mapper do
  subject { described_class.new.call(search_options_hash) }

  let(:search_options_hash) { {} }

  it { expect(subject).to be_a(Hash) }

  context 'when remote is string equaled "true"' do
    let(:search_options_hash) { { remote: 'true', position_type: 'part_time' } }

    it { expect(subject).to eq({remote: true, position_type: 'part_time'}) }    
  end

  context 'when remote is string equaled "false"' do
    let(:search_options_hash) { { remote: 'false', position_type: nil, location: 'New Vasyuki' } }

    it { expect(subject).to eq({remote: false, location: 'New Vasyuki'}) }
  end

  context 'when salary is string equaled "545" and salary_currency is missing' do
    let(:search_options_hash) { { remote: nil, position_type: nil, location: nil, salary: '545' } }

    it { expect(subject).to eq({salary: 545, salary_currency: 'rub'}) }
  end

  context 'when salary_currency is string equaled "usd"' do
    let(:search_options_hash) { { remote: nil, position_type: nil, location: nil, salary: nil, salary_currency: 'usd' } }

    it { expect(subject).to eq({salary_currency: 'usd'}) }
  end

  context 'when salary_currency and position_type are strings equaled bad value' do
    let(:search_options_hash) { { remote: nil, position_type: 'test_position', location: nil, salary: nil, salary_currency: 'test_cur' } }

    it { expect(subject).to eq({}) }
  end

  context 'when option is invalid' do
    let(:search_options_hash) { { invalid: 'option' } }

    it { expect(subject).to eq({}) }
  end

  context 'when position_type is invalid value and remote is valid "true"' do
    let(:search_options_hash) { { remote: 'true', position_type: 'fuull_time', location: nil, salary: nil, salary_currency: nil } }

    it { expect(subject).to eq({remote: true}) }
  end
end
