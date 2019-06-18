# frozen_string_literal: true

RSpec.describe VacancyRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#approve_by_pk' do
    subject { repo.approve_by_pk(vacancy_id) }

    let(:vacancy_id) { vacancy.id }

    context 'when vacancy exist and was not published' do
      let(:vacancy) { Fabricate.create(:vacancy, published: false) }

      it 'approves vacancy' do
        expect(subject).to eq(1)
        expect(repo.find(vacancy.id).published).to eq(true)
      end
    end

    context 'when vacancy exist and was published' do
      let(:vacancy) { Fabricate.create(:vacancy, published: true) }

      it 'approves vacancy' do
        expect(subject).to eq(1)
        expect(repo.find(vacancy.id).published).to eq(true)
      end
    end

    context 'when vacancy does not exist' do
      let(:vacancy_id) { nil }

      it 'approves vacancy' do
        expect(subject).to eq(0)
      end
    end
  end

  describe '#disapprove_by_pk' do
    subject { repo.disapprove_by_pk(vacancy_id) }

    let(:vacancy_id) { vacancy.id }

    context 'when vacancy exist and was not deleted' do
      let(:vacancy) { Fabricate.create(:vacancy, deleted_at: nil) }

      it 'approves vacancy' do
        expect(subject).to eq(1)
        expect(repo.find(vacancy.id).deleted_at).to_not eq(nil)
      end
    end

    context 'when vacancy exist and was deleted' do
      let(:vacancy) { Fabricate.create(:vacancy, deleted_at: Time.now) }

      it 'approves vacancy' do
        expect(subject).to eq(1)
        expect(repo.find(vacancy.id).deleted_at).to_not eq(nil)
      end
    end

    context 'when vacancy does not exist' do
      let(:vacancy_id) { nil }

      it 'approves vacancy' do
        expect(subject).to eq(0)
      end
    end
  end

  describe '#archive_for_today' do
    subject { repo.archive_for_today }

    context 'when some vacancies expiries today' do
      before do
        Fabricate.create(:vacancy, archived_at: Date.today)
        Fabricate.create(:vacancy, archived_at: Date.today + 1)
        Fabricate.create(:vacancy, archived_at: Date.today + 2)
      end

      it { expect(subject).to eq(1) }

      it 'archive vacancy only for today' do
        expect(repo.root.where(published: true, archived: false, deleted_at: nil).count).to eq(3)
        subject
        expect(repo.root.where(published: true, archived: false, deleted_at: nil).count).to eq(2)
      end
    end

    context 'when nothing expiries today' do
      before do
        Fabricate.create(:vacancy, archived_at: Date.today + 1)
        Fabricate.create(:vacancy, archived_at: Date.today + 2)
      end

      it { expect(subject).to eq(0) }

      it 'archive vacancy only for today' do
        expect(repo.root.where(published: true, archived: false, deleted_at: nil).count).to eq(2)
        subject
        expect(repo.root.where(published: true, archived: false, deleted_at: nil).count).to eq(2)
      end
    end
  end

  describe '#all_for_moderation' do
    subject { repo.all_for_moderation }

    before { Fabricate.create(:vacancy, published: published, archived: archived, deleted_at: deleted_at) }

    context 'when vacancy published and not archived or deleted' do
      let(:published) { true }
      let(:archived) { false }
      let(:deleted_at) { nil }

      it { expect(subject).to eq([]) }
    end

    context 'when vacancy published and archived' do
      let(:published) { true }
      let(:archived) { true }
      let(:deleted_at) { nil }

      it { expect(subject).to eq([]) }
    end

    context 'when vacancy published and deleted' do
      let(:published) { true }
      let(:archived) { false }
      let(:deleted_at) { Time.now }

      it { expect(subject).to eq([]) }
    end

    context 'when vacancy not published' do
      let(:published) { false }
      let(:archived) { false }
      let(:deleted_at) { nil }

      it { expect(subject.count).to eq(1) }
      it { expect(subject).to all(be_a(Vacancy)) }
      it { expect(subject.first.contact).to be_a(Contact) }
    end
  end

  describe '#find_with_contact' do
    subject { repo.find_with_contact(vacancy.id) }

    let(:vacancy) { Fabricate.create(:vacancy, published: published, archived: archived, deleted_at: deleted_at) }

    context 'when vacancy published and not archived or deleted' do
      let(:published) { true }
      let(:archived) { false }
      let(:deleted_at) { nil }

      it { expect(subject).to eq(vacancy) }
      it { expect(subject.contact).to be_a(Contact) }
    end

    context 'when vacancy published and archived' do
      let(:published) { true }
      let(:archived) { true }
      let(:deleted_at) { nil }

      it { expect(subject).to be(nil) }
    end

    context 'when vacancy published and deleted' do
      let(:published) { true }
      let(:archived) { false }
      let(:deleted_at) { Time.now }

      it { expect(subject).to be(nil) }
    end

    context 'when vacancy not published' do
      let(:published) { false }
      let(:archived) { false }
      let(:deleted_at) { nil }

      it { expect(subject).to be(nil) }
    end
  end
end
