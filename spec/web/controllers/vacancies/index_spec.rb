# frozen_string_literal: true

RSpec.describe Web::Controllers::Vacancies::Index, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success(result: [Vacancy.new(id: 123)], pager: pager) } }
  let(:pager) { instance_double('Hanami::Pagination::Pager') }

  let(:params) { Hash[] }

  context 'when operation returns success value' do
    it { expect(subject).to be_success }

    it 'exposes list of vacancies' do
      subject
      expect(action.vacancies).to eq([Vacancy.new(id: 123)])
      expect(action.pager).to eq(pager)
    end

    context 'when params includes query param' do
      let(:params) { { query: 'remote:true search text' } }

      it { expect(subject).to be_success }

      it do
        expect(operation).to receive(:call).with(page: nil, search_query: { remote: 'true', text: 'search text' })
        subject
      end
    end

    context 'when params inlcludes unexpected keys' do
      let(:params) { { page: 2, unexpected_key: 'hello' } }

      it { expect(subject).to be_success }
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    before do
      12.times { Fabricate.create(:vacancy, published: true, archived: false) }
    end

    context 'opens the first pagination page' do
      let(:params) { { page: 1 } }

      it { expect(subject).to be_success }

      it 'exposes right list of vacancies' do
        subject
        expect(action.vacancies.count).to eq(10)
      end
    end

    context 'opens the second pagination page' do
      let(:params) { { page: 2 } }

      it { expect(subject).to be_success }

      it 'exposes right list of vacancies' do
        subject
        expect(action.vacancies.count).to eq(2)
      end
    end

    context 'when params inlcludes unexpected keys' do
      let(:params) { { page: 2, unexpected_key: 'hello' } }

      it { expect(subject).to be_success }
    end
  end
end
