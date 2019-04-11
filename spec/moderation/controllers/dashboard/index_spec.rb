# frozen_string_literal: true

RSpec.describe Moderation::Controllers::Dashboard::Index, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success([Vacancy.new(id: 123)]) } }

  let(:params) { Hash[] }

  context 'when operation returns success value' do
    it { expect(subject).to be_success }

    it 'exposes list of vacancies' do
      subject
      expect(action.vacancies).to eq([Vacancy.new(id: 123)])
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }
    let(:params) { Hash[] }

    it { expect(subject).to be_success }
  end
end
