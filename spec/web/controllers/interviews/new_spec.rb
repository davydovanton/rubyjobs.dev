# frozen_string_literal: true

RSpec.describe Web::Controllers::Interviews::New, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }

  let(:session) { { account: Account.new(id: 1) } }
  let(:params) { { company_id: 0, 'rack.session' => session } }

  context 'when operation returns success value' do
    let(:operation) { ->(*) { Success(Company.new(id: 0)) } }

    it { expect(subject).to be_success }

    it 'call operation with a right contract' do
      expect(operation).to receive(:call).with(id: 0)
      subject
    end

    it 'exposes vacancy' do
      subject
      expect(action.company).to eq(Company.new(id: 0))
    end
  end

  context 'when operation returns failure value' do
    let(:operation) { ->(*) { Failure(:not_found) } }

    it { expect(subject).to redirect_to '/companies' }

    it 'call operation with a right contract' do
      expect(operation).to receive(:call).with(id: 0)
      subject
    end
  end

  context 'with real dependencies' do
    let(:session) { { account: Fabricate(:account) } }
    let(:action) { described_class.new }
    let(:params) { { id: company.id, 'rack.session' => session } }

    let(:company) { Fabricate.create(:company) }

    it { expect(subject).to be_success }
  end

  context 'when not authorised' do
    let(:session) { {} }
    let(:action) { described_class.new }

    it { expect(subject).to redirect_to '/' }
  end
end
