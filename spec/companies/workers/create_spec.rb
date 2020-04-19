# frozen_string_literal: true

RSpec.describe Companies::Workers::Create, type: :workers do
  subject { worker.perform('google', 'https://google.com') }

  let(:worker) { described_class.new(operation: operation, logger: logger, rollbar: rollbar) }
  let(:operation) { instance_double('Companies::Operations::Create', call: result) }
  let(:logger) { double(:logger, info: true, error: true) }
  let(:rollbar) { double(:rollbar, info: true, error: true) }

  context 'when operation returns success value' do
    let(:result) { Success(Company.new(name: 'google')) }

    it 'calls logger' do
      expect(logger).to receive(:info).with('created google company')
      subject
    end
  end

  context 'when operation returns failure value' do
    let(:result) { Failure(:error) }

    it 'calls logger' do
      expect(rollbar).to receive(:error).with('create company flow is broken, error')
      subject
    end
  end

  context 'with real dependencies' do
    let(:worker) { described_class.new }

    before do
      Fabricate.create(:company, name: 'other')
    end

    it { expect(subject).to be true }
  end
end
