# frozen_string_literal: true

RSpec.describe Analitics::Operations::IncreaseVacancyViewCount, type: :operation do
  subject { operation.call(vacancy_id: 1) }

  let(:operation) { described_class.new() }
  # let(:subscriber_repo) { instance_double('SubscriberRepository', create: Subscriber.new(email: email)) }

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call(vacancy_id: 1) }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
