# frozen_string_literal: true

RSpec.describe Vacancies::Operations::Create, type: :operation do
  let(:operation) { described_class.new }

  subject { operation.call }

  it { expect(subject).to be_success }
  it { expect(subject.value!).to be_a(Vacancy) }

  xcontext 'with real dependencies' do
    let(:operation) { described_class.new }

    subject { operation.call }

    it { expect(subject).to be_success }
  end
end
