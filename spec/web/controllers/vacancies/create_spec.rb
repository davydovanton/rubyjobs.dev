# frozen_string_literal: true

RSpec.describe Web::Controllers::Vacancies::Create, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }

  let(:params) do
    {
      vacancy: {
        position: 'ruby developer',
        position_type: 'full_time',
        details_raw: 'test something here',
        location: 'moscow',
        remote_available: '1',
        salary: {
          min: '1000000',
          max: '222222222',
          currency: 'rub',
          unit: 'monthly'
        },
        archived_in_weeks: '2',
        tags: 'rails, golang, PostgreSQL',
        contact: {
          email: 'test@something.com',
          full_name: 'First Name',
          company: 'test',
          site: ''
        }
      }
    }
  end

  it 'serealize data to valid format' do
    expect(operation).to receive(:call).with(
      vacancy: {
        position: 'ruby developer',
        position_type: 'full_time',

        details_raw: 'test something here',

        location: 'moscow',
        remote_available: true,

        salary_min: 1_000_000,
        salary_max: 222_222_222,
        salary_currency: 'rub',
        salary_unit: 'monthly',

        archived_in_weeks: 2,
        tags: %w[rails golang postgresql]
      },
      contact: { email: 'test@something.com', full_name: 'First Name', company: 'test', site: '' }
    )

    subject
  end

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }
    let(:success_flash) { 'Вакансия успешно отправлена на модерацию. В ближайшее время она появится на главной.' }

    it { expect(subject).to redirect_to '/' }
    it 'show flash message' do
      subject
      expect(action.exposures[:flash][:success]).to eq(success_flash)
    end
  end

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Failure(:error) } }

    it { expect(subject).to have_http_status(200) }
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    it { expect(subject).to redirect_to '/' }
  end
end
