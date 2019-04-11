# frozen_string_literal: true

RSpec.describe Vacancies::Operations::Show, type: :operation do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(vacancy_repo: vacancy_repo) }
  let(:vacancy_repo) { instance_double('VacancyRepository', find_with_contact: vacancy) }

  context 'when vacancy exists' do
    let(:vacancy) { Vacancy.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Vacancy.new) }
  end

  context 'when vacancy does not exist' do
    let(:vacancy) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
  end

  context 'with real dependencies' do
    subject { operation.call(id: vacancy.id) }

    let(:operation) { described_class.new }
    let(:vacancy) { Fabricate.create(:vacancy, published: true, archived: false) }

    it { expect(subject).to be_success }
  end
end
