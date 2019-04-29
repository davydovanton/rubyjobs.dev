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
  end

  context 'when action receive unexpected parameters' do
    let(:params) do
      {
        page: 1,
        foo: 'bar'
      }
    end

    it 'sanitizes params' do
      expect(operation).to receive(:call).with(page: 1)
      subject
    end
  end
end
