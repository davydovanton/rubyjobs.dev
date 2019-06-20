# typed: ignore
# frozen_string_literal: true

RSpec.describe Subscribers::Workers::WeeklyNewsletter, type: :workers do
  subject { worker.perform }

  let(:worker) { described_class.new(operation: operation, logger: logger, rollbar: rollbar) }
  let(:operation) { instance_double('Subscribers::Operations::WeeklyNewsletter', call: result) }
  let(:logger) { double(:logger, info: true, error: true) }
  let(:rollbar) { double(:rollbar, info: true, error: true) }

  context 'when operation returns success value' do
    let(:result) { Success(archived_count: 1) }

    it 'calls logger' do
      # expect(logger).to receive(:info).with('archived 1 vacancies')
      expect(logger).to receive(:info)
      subject
    end
  end

  context 'when operation returns failure value' do
    let(:result) { Failure(archived_count: 1) }

    it 'calls logger' do
      # expect(rollbar).to receive(:error).with('archived flow is broken')
      expect(rollbar).to receive(:error)
      subject
    end
  end

  context 'with real dependencies' do
    let(:worker) { described_class.new }

    before do
      Fabricate.create(:vacancy, archived_at: Date.today)
      Fabricate.create(:vacancy, archived_at: Date.today + 1)
      Fabricate.create(:vacancy, archived_at: Date.today + 2)
    end

    xit { expect(subject).to be true }
  end
end
