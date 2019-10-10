# frozen_string_literal: true

RSpec.describe Web::Controllers::Vacancies::Show, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      operation: operation,
      analitics_operation: analitics_operation
    )
  end

  let(:analitics_operation) { ->(*) { Success(VacancyAnalitic.new(id: 1)) } }
  let(:params) { { id: 1 } }

  context 'when operation returns success value' do
    let(:operation) { ->(*) { Success(Vacancy.new(id: 1)) } }

    it { expect(subject).to be_success }

    it 'call operation with a right contract' do
      expect(operation).to receive(:call).with(id: 1)
      subject
    end

    it 'exposes vacancy' do
      subject
      expect(action.vacancy).to eq(Vacancy.new(id: 1))
    end

    context 'and analitics operation returnt success result' do
      let(:analitics_operation) { ->(*) { Success(VacancyAnalitic.new(id: 1)) } }

      it { expect(subject).to be_success }

      it 'exposes analitics object' do
        subject
        expect(action.analitics).to eq(VacancyAnalitic.new(id: 1))
      end
    end

    context 'and analitics operation returnt failure result' do
      let(:analitics_operation) { ->(*) { Failure(:something) } }

      it { expect(subject).to be_success }

      it 'exposes analitics object' do
        subject
        expect(action.analitics).to eq(VacancyAnalitic.new)
      end
    end
  end

  context 'when operation returns failure value' do
    let(:operation) { ->(*) { Failure(:not_found) } }

    it { expect(subject).to redirect_to '/' }

    it 'call operation with a right contract' do
      expect(operation).to receive(:call).with(id: 1)
      subject
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }
    let(:params) { { id: vacancy.id } }

    let(:vacancy) { Fabricate.create(:vacancy, published: true) }

    it { expect(subject).to be_success }
  end
end
