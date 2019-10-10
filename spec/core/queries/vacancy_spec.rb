# frozen_string_literal: true

RSpec.describe Queries::Vacancy, type: :query do
  let(:repo) { described_class.new }

  describe '#all_with_contact' do
    subject { repo.all_with_contact(limit: 10, page: 1) }

    before { Fabricate.create(:vacancy, published: published, archived_at: archived_at, deleted_at: deleted_at) }

    context 'when vacancy published and not archived or deleted' do
      let(:published) { true }
      let(:archived_at) { (Time.now + (60 * 60 * 24)).to_date }
      let(:deleted_at) { nil }

      it { expect(subject.count).to eq(1) }
      it { expect(subject).to all(be_a(Vacancy)) }
      it { expect(subject.first.contact).to be_a(Contact) }
    end

    context 'when vacancy published and archived' do
      let(:published) { true }
      let(:archived_at) { Date.today }
      let(:deleted_at) { nil }

      it { expect(subject).to eq([]) }
    end

    context 'when vacancy published and deleted' do
      let(:published) { true }
      let(:archived_at) { (Time.now + (60 * 60 * 24)).to_date }
      let(:deleted_at) { Time.now }

      it { expect(subject).to eq([]) }
    end

    context 'when vacancy not published' do
      let(:published) { false }
      let(:archived_at) { (Time.now + (60 * 60 * 24)).to_date }
      let(:deleted_at) { nil }

      it { expect(subject).to eq([]) }
    end
  end
end
