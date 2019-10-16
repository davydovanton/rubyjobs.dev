# frozen_string_literal: true

RSpec.describe Moderation::Controllers::Dashboard::Show, type: :action do
  subject { action.call(params) }

  let(:params) { { id: 42 } }
  let(:action) { described_class.new(operation: operation) }
  let(:operation) { instance_double('Vacancies::Operations::VacancyForModeration') }

  context 'when operation returns success value' do
    let(:vacancy) { Fabricate.build(:vacancy) }
    let(:params) { { id: 42 } }

    before do
      allow(operation).to receive(:call).with(id: 42).and_return(Success(vacancy))
    end

    it { expect(subject).to be_success }

    it 'exposes list of vacancies' do
      subject
      expect(action.vacancy).to eq(vacancy)
    end
  end

  context 'when operation returns success value' do
    before do
      allow(operation).to receive(:call).with(id: 42).and_return(Failure(:not_found))
    end

    it { expect(subject).to redirect_to '/moderation' }
  end

end
