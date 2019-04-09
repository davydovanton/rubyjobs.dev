RSpec.describe Web::Controllers::Vacancies::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }

  let(:params) { { id: 1 } }

  subject { action.call(params) }

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
    let(:action) { described_class.new }
    let(:params) { { id: vacancy.id } }

    let(:vacancy) { Fabricate.create(:vacancy, published: true, archived: false) }

    subject { action.call(params) }

    it { expect(subject).to be_success }
  end
end
