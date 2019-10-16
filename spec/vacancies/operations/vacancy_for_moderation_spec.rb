# frozen_string_literal: true

RSpec.describe Vacancies::Operations::VacancyForModeration, type: :operation do
  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }
  let(:vacancy_repo) { instance_double('VacancyRepository') }
  let(:vacancy) { Fabricate.build(:vacancy) }

  before do
    allow(vacancy_repo).to receive(:find_for_moderation).and_return(nil)
    allow(vacancy_repo).to receive(:find_for_moderation).with(42).and_return(vacancy)
  end

  context 'when a vacancy exists' do
    subject { operation.call(id: 42) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(vacancy) }
  end

  context "when a vacancy doesn't exist" do
    subject { operation.call(id: 10) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
  end
end
