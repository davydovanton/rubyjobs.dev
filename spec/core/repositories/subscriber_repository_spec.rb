# frozen_string_literal: true

RSpec.describe SubscriberRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_email' do
    let(:email) { 'anton@test.com' }

    subject { repo.find_by_email(email) }

    context 'when subscriber with email exist' do
      before { repo.create(email: email) }

      it { expect(subject).to be_a(Subscriber) }
      it { expect(subject.email).to eq(email) }
    end

    context 'when subscriber with email does not exist' do
      it { expect(subject).to be nil }
    end
  end
end
