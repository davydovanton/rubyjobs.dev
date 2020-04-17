# frozen_string_literal: true

RSpec.describe Vacancies::Queries::Vacancy, type: :query do
  let(:query_object) { described_class.new }
  let(:search_object) { Web::DTO::SearchOptions.new }

  describe '#all_with_contact' do
    subject { query_object.all_with_contact(limit: 10, page: 1, search_object: search_object) }

    let(:remote_available) { nil }
    let(:position_type) { nil }
    let(:location) { nil }

    before do
      Fabricate.create(
        :vacancy,
        position: 'Test searchable position',
        details_raw: 'Any text here, for example hanami',
        published: published,
        deleted_at: deleted_at,
        archived_at: archived_at,
        remote_available: remote_available,
        position_type: position_type,
        location: location
      )
    end

    context 'when vacancy published and not archived or deleted' do
      let(:published) { true }
      let(:archived_at) { (Time.now + (60 * 60 * 24)).to_date }
      let(:deleted_at) { nil }

      it { expect(subject.count).to eq(1) }
      it { expect(subject).to all(be_a(Vacancy)) }
      it { expect(subject.first.contact).to be_a(Contact) }

      context 'and remote in search_object is true' do
        let(:search_object) { Web::DTO::SearchOptions.new(remote: true) }

        it { expect(subject).to eq([]) }

        context 'and remote_available in record is true as well' do
          let(:remote_available) { true }

          it { expect(subject.count).to eq(1) }
        end
      end

      context 'and remote in search_object is false' do
        let(:search_object) { Web::DTO::SearchOptions.new(remote: false) }
        let(:remote_available) { true }

        it { expect(subject.count).to eq(0) }
      end

      context 'and position_type in search_object is equal "other"' do
        let(:search_object) { Web::DTO::SearchOptions.new(position_type: 'other') }

        it { expect(subject).to eq([]) }

        context 'and position_type in record is "other" as well' do
          let(:position_type) { 'other' }

          it { expect(subject.count).to eq(1) }
        end
      end

      context 'and location in search query is not empty' do
        let(:search_object) { Web::DTO::SearchOptions.new(location: 'VASYUKI') }

        it { expect(subject).to eq([]) }

        context 'and location in record includes location from search query' do
          let(:location) { 'New Vasyuki' }

          it { expect(subject.count).to eq(1) }
        end
      end

      context 'and text in search query is not empty' do
        it 'searches in the position field' do
          search_object = Web::DTO::SearchOptions.new(text: 'searchable')
          vacancies = query_object.all_with_contact(limit: 10, page: 1, search_object: search_object)

          expect(vacancies.count).to eq(1)
        end

        it 'searches in the details field' do
          search_object = Web::DTO::SearchOptions.new(text: 'hanami')
          vacancies = query_object.all_with_contact(limit: 10, page: 1, search_object: search_object)

          expect(vacancies.count).to eq(1)
        end

        context 'and text in record not includes location from search query' do
          let(:search_object) { Web::DTO::SearchOptions.new(text: 'rails') }

          it { expect(subject).to eq([]) }
        end
      end
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
