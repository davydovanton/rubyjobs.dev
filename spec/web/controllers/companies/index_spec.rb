# frozen_string_literal: true

RSpec.describe Web::Controllers::Companies::Index, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }

  let(:params) { Hash[] }

  context 'when operation returns success value' do
    let(:operation) { ->(*) { Success([Company.new(id: 0)]) } }

    it { expect(subject).to be_success }

    it 'exposes list of vacancies' do
      subject
      expect(action.companies).to eq([Company.new(id: 0)])
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    before do
      2.times { |i| Fabricate.create(:company, name: "Test##{i}") }
    end

    it { expect(subject).to be_success }
  end
end
