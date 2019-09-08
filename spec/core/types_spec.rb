# frozen_string_literal: true

RSpec.describe Core::Types do
  describe 'LoggerLevel' do
    let(:type) { Core::Types::LoggerLevel }

    [
      [nil, :info],

      %i[trace trace],
      %i[unknown unknown],
      %i[error error],
      %i[fatal fatal],
      %i[warn warn],
      %i[info info],
      %i[debug debug],

      ['trace', :trace],
      ['unknown', :unknown],
      ['error', :error],
      ['fatal', :fatal],
      ['warn', :warn],
      ['info', :info],
      ['debug', :debug]
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['other'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:other] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'UUID' do
    let(:type) { Core::Types::UUID }
    let(:uuid) { SecureRandom.uuid }

    it { expect(type[uuid]).to eq(uuid) }
    it { expect { type['anything'] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'VacancyPositionTypes' do
    let(:type) { Core::Types::VacancyPositionTypes }

    [
      [nil, 'full_time'],

      %w[full_time full_time],
      %w[part_time part_time],
      %w[contractor contractor],
      %w[temp temp],
      %w[other other],

      [:full_time, 'full_time'],
      [:part_time, 'part_time'],
      [:contractor, 'contractor'],
      [:temp, 'temp'],
      [:other, 'other']
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'VacancySalaryCurrencyTypes' do
    let(:type) { Core::Types::VacancySalaryCurrencyTypes }

    [
      [nil, 'rub'],

      %w[rub rub],
      %w[usd usd],
      %w[eur eur],

      [:rub, 'rub'],
      [:usd, 'usd'],
      [:eur, 'eur']
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'VacancySalaryUnitTypes' do
    let(:type) { Core::Types::VacancySalaryUnitTypes }

    [
      [nil, 'monthly'],

      ['monthly', 'monthly'],
      ['yearly', 'yearly'],
      ['by hour', 'by hour'],
      ['per project', 'per project'],

      [:monthly, 'monthly'],
      [:yearly, 'yearly'],
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'ViewCount' do
    let(:type) { Core::Types::ViewCount }

    [
      [0, 0],

      [1, 1],
      [10_000, 10_000]
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['1'] }.to raise_error(ArgumentError) }
    it { expect { type['asd'] }.to raise_error(ArgumentError) }

    it { expect { type[-1] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[-10_000] }.to raise_error(Dry::Types::ConstraintError) }
  end
end
