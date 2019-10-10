# frozen_string_literal: true

RSpec.describe Vacancies::Operations::Create, type: :operation do
  subject { operation.call(contact: contact_payload, vacancy: vacancy_payload) }

  let(:operation) do
    described_class.new(vacancy_repo: vacancy_repo, contact_repo: contact_repo)
  end

  let(:vacancy_repo) { instance_double('VacancyRepository', transaction: Vacancy.new, create: Vacancy.new) }
  let(:contact_repo) { instance_double('ContactRepository', create: Vacancy.new) }

  let(:vacancy_payload) do
    {
      position: 'ruby developer',
      position_type: 'full_time',

      details_raw: 'test something here',

      location: 'moscow',
      remote_available: true,

      salary_min: 1_000_000,
      salary_max: 222_222_222,
      salary_currency: 'rub',
      salary_unit: 'monthly',

      archived_in_weeks: 2
    }
  end

  let(:contact_payload) do
    { email: 'test@something.com', full_name: 'First Name', company: 'test', site: '' }
  end

  context 'when contact and vacancy data is valid' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Vacancy) }
  end

  context 'when contact payload is invalid' do
    let(:contact_payload) { {} }

    it { expect(subject).to be_failure }
  end

  context 'when vacancy payload is invalid' do
    let(:vacancy_payload) { {} }

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    subject { operation.call(contact: contact_payload, vacancy: vacancy_payload) }

    let(:operation) { described_class.new }
    let(:two_weeks_after) { (Time.now + 2 * (60 * 60 * 24 * 7)).to_date }

    it { expect(subject).to be_success }

    # HACK: I had troubles to mock `#create` call in transaction block. that's why I createad this hack
    it 'setup specific values' do
      vacancy = subject.value!

      expect(vacancy.to_h[:archived_at].to_date).to eq(two_weeks_after)

      expect(vacancy.to_h).to include(
        position: 'ruby developer',
        position_type: 'full_time',

        details_raw: 'test something here',
        details: "<p>test something here</p>\n",

        location: 'moscow',
        remote_available: true,

        salary_min: 1_000_000,
        salary_max: 222_222_222,
        salary_currency: 'rub',
        salary_unit: 'monthly',

        published: false,
        deleted_at: nil
      )
    end
  end
end
