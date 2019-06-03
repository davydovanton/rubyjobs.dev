# frozen_string_literal: true

RSpec.describe Subscribers::Operations::Create, type: :operation do
  subject { operation.call(email: email) }

  let(:operation) { described_class.new(subscriber_repo: subscriber_repo) }
  let(:subscriber_repo) { instance_double('SubscriberRepository', create: Subscriber.new(email: email)) }

  context 'when email is valid' do
    let(:email) { 'test@something.com' }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Subscriber) }
    it { expect(subject.value!.email).to eq('test@something.com') }
  end

  context 'when email is invalid' do
    [
      'something.com',
      '@something.com',
      'something@.com',
      'something@com',
      'something@',
      '@something'
    ].each do |invalid_email|

      let(:email) { invalid_email }

      it { expect(subject).to be_failure }
    end
  end

  context 'when someting wrong with db' do
    let(:email) { 'test@something.com' }

    before do
      allow(subscriber_repo).to receive(:create).and_raise(Hanami::Model::UniqueConstraintViolationError)
    end

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    subject { operation.call(email: email) }

    let(:operation) { described_class.new }
    let(:email) { 'test@something.com' }

    it { expect(subject).to be_success }
    it do
      expect { subject }.to change { SubscriberRepository.new.all.count }.by(1)
    end
  end
end
