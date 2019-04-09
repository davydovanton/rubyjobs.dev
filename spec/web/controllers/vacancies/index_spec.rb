RSpec.describe Web::Controllers::Vacancies::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success([Vacancy.new(id: 123)]) } }

  let(:params) { Hash[] }

  subject { action.call(params) }

  context 'when operation returns success value' do
    it { expect(subject).to be_success }

    it 'exposes list of vacancies' do
      subject
      expect(action.vacancies).to eq([Vacancy.new(id: 123)])
    end
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:params) { Hash[] }

    subject { action.call(params) }
  end
end
