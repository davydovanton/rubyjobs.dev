# frozen_string_literal: true

RSpec.describe Vacancies::Operations::List, type: :operation do
  subject { operation.call }

  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }

  let(:vacancy_repo) do
    instance_double('VacancyRepository', all_with_contact: vacancies, pager_for_all_with_contact: pager)
  end

  let(:pager) { instance_double('Hanami::Pagination::Pager') }

  context 'when vacancies exists' do
    let(:vacancies) { [Vacancy.new] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(result: [Vacancy.new], pager: pager) }
  end

  context 'when vacancies does not exist' do
    let(:vacancies) { [] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(result: [], pager: pager) }
  end

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
