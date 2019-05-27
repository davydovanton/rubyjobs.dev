# frozen_string_literal: true

RSpec.describe Analitics::Operations::IncreaseVacancyViewCount, type: :operation do
  subject { operation.call(vacancy_id: 1) }

  let(:operation) { described_class.new(vacancy_analitic_repo: repo) }
  let(:repo) do
    instance_double(
      'VacancyAnaliticRepository',
      increase_view_count: VacancyAnalitic.new(vacancy_id: 1, view_count: 11)
    )
  end

  it { expect(subject).to be_success }
  it { expect(subject.value!).to be_a(VacancyAnalitic) }

  context 'with real dependencies' do
    subject { operation.call(vacancy_id: vacancy.id) }

    let(:operation) { described_class.new }
    let(:vacancy) { Fabricate.create(:vacancy, published: false) }

    it { expect(subject).to be_success }
  end
end
