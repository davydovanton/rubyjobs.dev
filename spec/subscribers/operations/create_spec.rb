# frozen_string_literal: true

RSpec.describe Subscribers::Operations::Create, type: :operation do
  subject { operation.call(email: email) }

  let(:operation) do
    described_class.new
  end

  # let(:contact_repo) { instance_double('ContactRepository', create: Vacancy.new) }

  context 'when email is valid' do
    let(:email) { 'test@something.com' }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Subscriber) }
    it { expect(subject.value!.email).to eq('test@something.com') }
  end

  context 'when email is invalid' do
    let(:email) { 'something.com' }

    xit { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    subject { operation.call(email: email) }

    let(:operation) { described_class.new }
    let(:email) { 'test@something.com' }

    it { expect(subject).to be_success }
  end
end
