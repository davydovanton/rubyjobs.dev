# frozen_string_literal: true

RSpec.describe Vacancies::Operations::List, type: :operation do
  subject { operation.call }

  let(:operation) { described_class.new(vacancy_query: vacancy_query) }

  let(:vacancy_query) do
    instance_double('Queries::Vacancy', all_with_contact: vacancies, pager_for_all_with_contact: pager)
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

  context 'with remote query' do
    subject { operation.call(search_query: { remote: remote_query }) }

    let(:vacancies) { [] }

    context 'when remote_query nil' do
      let(:remote_query) { nil }

      it do
        expect(vacancy_query)
          .to receive(:all_with_contact)
          .with(limit: 10, page: 1, remote_available: nil)
        subject
      end
    end

    context 'when remote_query not true or false string' do
      let(:remote_query) { 'not true or false string' }

      it do
        expect(vacancy_query)
          .to receive(:all_with_contact)
          .with(limit: 10, page: 1, remote_available: nil)
        subject
      end
    end

    context 'when remote_query true' do
      let(:remote_query) { 'true' }

      it do
        expect(vacancy_query)
          .to receive(:all_with_contact)
          .with(limit: 10, page: 1, remote_available: true)
        subject
      end
    end

    context 'when remote_query false' do
      let(:remote_query) { 'false' }

      it do
        expect(vacancy_query)
          .to receive(:all_with_contact)
          .with(limit: 10, page: 1, remote_available: false)
        subject
      end
    end
  end

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
