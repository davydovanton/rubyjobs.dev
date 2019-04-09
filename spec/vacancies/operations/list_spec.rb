# frozen_string_literal: true

RSpec.describe Vacancies::Operations::List, type: :operation do
  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }
  let(:vacancy_repo) { instance_double('VacancyRepository', all_with_contact: vacancies) }

  subject { operation.call }

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
    let(:operation) { described_class.new }

    subject { operation.call }

    it { expect(subject).to be_success }
  end
end
