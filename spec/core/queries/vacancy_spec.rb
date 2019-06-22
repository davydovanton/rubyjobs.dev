# frozen_string_literal: true

RSpec.describe Queries::Vacancy, type: :query do
  let(:repo) { described_class.new }

  describe '#all_with_contact' do
    subject { repo.all_with_contact(limit: 10, page: 1, remote_available: remote_available) }

    let(:remote_available) { nil }

    before do
      Fabricate.create(:vacancy, published: published, archived: archived,
                                 deleted_at: deleted_at, remote_available: false)
    end

    context 'when vacancy published and not archived or deleted' do
      let(:published) { true }
      let(:archived) { false }
      let(:deleted_at) { nil }

      it { expect(subject.count).to eq(1) }
      it { expect(subject).to all(be_a(Vacancy)) }
      it { expect(subject.first.contact).to be_a(Contact) }

      context 'when remote_available is true' do
        let(:remote_available) { true }

        it { expect(subject).to eq([]) }
      end
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

      it { expect(subject).to eq([]) }
    end
  end
end
