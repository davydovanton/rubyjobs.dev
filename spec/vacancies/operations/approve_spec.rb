# typed: ignore
# frozen_string_literal: true

RSpec.describe Vacancies::Operations::Approve, type: :operation do
  subject { operation.call(id: 1) }

  let(:operation) do
    described_class.new(vacancy_repo: vacancy_repo)
  end

  let(:vacancy_repo) { instance_double('VacancyRepository', approve_by_pk: 1) }

  it { expect(subject).to be_success }
  it { expect(subject.value!).to eq(1) }

  context 'with real dependencies' do
    subject { operation.call(id: vacancy.id) }

    let(:operation) { described_class.new }
    let(:vacancy) { Fabricate.create(:vacancy, archived_at: Date.today) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(1) }
  end
end
