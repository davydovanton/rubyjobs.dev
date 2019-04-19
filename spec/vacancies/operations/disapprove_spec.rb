# frozen_string_literal: true

RSpec.describe Vacancies::Operations::Disapprove, type: :operation do
  subject { operation.call(id: 1) }

  let(:operation) do
    described_class.new(vacancy_repo: vacancy_repo)
  end

  let(:vacancy_repo) { instance_double('VacancyRepository', transaction: Vacancy.new, create: Vacancy.new) }

  it { expect(subject).to be_success }
  it { expect(subject.value!).to eq(1) }

  context 'with real dependencies' do
    subject { operation.call(id: 1) }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(1) }
  end
end
