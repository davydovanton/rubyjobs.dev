# typed: ignore
# frozen_string_literal: true

RSpec.describe Subscribers::Operations::WeeklyNewsletter, type: :operation do
  subject { operation.call }

  let(:operation) { described_class.new(subscriber_repo: subscriber_repo) }
  let(:subscriber_repo) { instance_double('SubscriberRepository') }

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
