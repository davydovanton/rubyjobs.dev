# frozen_string_literal: true

RSpec.describe Vacancies::Operations::ListForModeration, type: :operation do
  subject { operation.call }

  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }
  let(:vacancy_repo) { instance_double('VacancyRepository', all_for_moderation: vacancies) }

  context 'when vacancies exists' do
    let(:vacancies) { [Vacancy.new] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Vacancy.new]) }
  end

  context 'when vacancies does not exist' do
    let(:vacancies) { [] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
