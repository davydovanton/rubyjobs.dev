# frozen_string_literal: true

RSpec.describe Companies::Operations::Create, type: :operation do
  subject { operation.call }

  let(:operation) do
    described_class.new
  end

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
