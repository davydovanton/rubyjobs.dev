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
end
