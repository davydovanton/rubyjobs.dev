# frozen_string_literal: true

RSpec.describe Vacancies::Operations::ArchiveForToday, type: :operation do
  subject { operation.call }

  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }
  let(:vacancy_repo) { instance_double('VacancyRepository', archive_for_today: 1) }

  context 'when vacancies for archive exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(archived_count: 1) }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }

    before do
      Fabricate.create(:vacancy, archived_at: Date.today)
      Fabricate.create(:vacancy, archived_at: Date.today + 1)
      Fabricate.create(:vacancy, archived_at: Date.today + 2)
    end

    it { expect(subject).to be_success }
  end
end
