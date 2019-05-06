# frozen_string_literal: true

RSpec.describe Moderation::Controllers::VacancyApprove::Update, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(rollbar: rollbar, operation: operation) }
  let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }
  let(:rollbar) { double(:rollbar, error: nil) }

  let(:params) { { id: 1 } }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }

    it { expect(subject).to redirect_to '/moderation' }
  end

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Failure(:error) } }

    it { expect(subject).to redirect_to '/moderation' }

    it 'sends error to rollbar' do
      expect(rollbar).to receive(:error).with(:error)
      subject
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }
    let(:params) { { id: vacancy.id } }
    let(:vacancy) { Fabricate.create(:vacancy, published: false, archived: false) }

    it { expect(subject).to redirect_to '/moderation' }
  end
end
