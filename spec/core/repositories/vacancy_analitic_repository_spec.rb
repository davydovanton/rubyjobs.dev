# frozen_string_literal: true

RSpec.describe VacancyAnaliticRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:vacancy) { Fabricate.create(:vacancy) }

  describe '#increase_view_count' do
    subject { repo.increase_view_count(vacancy.id) }

    context 'when vacancy has analitics in DB' do
      before do
        repo.create(vacancy_id: vacancy.id, view_count: 10)
      end

      it { expect(subject).to be_a(VacancyAnalitic) }
      it { expect(subject.view_count).to eq(11) }
    end

    context 'when vacancy does not have analitics in DB' do
      it { expect(subject).to be_a(VacancyAnalitic) }
      it { expect(subject.view_count).to eq(1) }
      it { expect { subject }.to change { repo.all.count }.by(1) }
    end
  end
end
