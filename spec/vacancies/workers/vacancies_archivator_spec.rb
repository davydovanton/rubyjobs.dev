# frozen_string_literal: true

RSpec.describe Vacancies::Workers::VacanciesArchivator, type: :workers do
  subject { worker.perform }

  let(:worker) { described_class.new(operation: operation, logger: logger, rollbar: rollbar) }
  let(:operation) { instance_double('Vacancies::Operations::ArchiveForToday', call: result) }
  let(:logger) { double(:logger, info: true, error: true) }
  let(:rollbar) { double(:rollbar, info: true, error: true) }

  context 'when operation returns success value' do
    let(:result) { Success(archived_count: 1) }

    it 'calls logger' do
      expect(logger).to receive(:info).with('archived 1 vacancies')
      subject
    end
  end

  context 'when operation returns failure value' do
    let(:result) { Failure(archived_count: 1) }

    it 'calls logger' do
      expect(rollbar).to receive(:error).with('archived flow is broken')
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

    it { expect(subject).to be true }
  end
end
