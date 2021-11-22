# frozen_string_literal: true

RSpec.describe Vacancies::Mappers::Vacancy, type: :mapper do
  subject { mapper.call(contact: contact_payload, **vacancy_payload) }

  let(:mapper) { described_class.new }

  let(:vacancy_payload) do
    {
      position: 'ruby developer',
      position_type: 'full_time',

      details_raw: 'test something here',

      location: 'moscow',
      remote_available: '1',

      salary: {
        min: '1_000_000',
        max: '222_222_222',
        currency: 'rub',
        unit: 'monthly'
      },

      archived_in_weeks: '2',
      tags: 'psql, go'
    }
  end

  let(:contact_payload) do
    { email: 'test@something.com', full_name: 'First Name', company: '   test', site: '' }
  end

  it 'maps data to right hash' do
    expect(subject).to eq(
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
        tags: %w[psql go]
      },

      contact: {
        email: 'test@something.com',
        full_name: 'First Name',
        company: 'test',
        site: ''
      }
    )
  end

  context 'when salary value is string with empty spaces' do
    let(:vacancy_payload) do
      {
        position: 'ruby developer',
        position_type: 'full_time',

        details_raw: 'test something here',

        location: 'moscow',
        remote_available: '1',

        salary: {
          min: '1 000 000',
          max: '222 222 222',
          currency: 'rub',
          unit: 'monthly'
        },

        archived_in_weeks: '2',
        tags: 'psql, go'
      }
    end

    it 'maps data to right hash' do
      expect(subject).to eq(
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
          tags: %w[psql go]
        },

        contact: {
          email: 'test@something.com',
          full_name: 'First Name',
          company: 'test',
          site: ''
        }
      )
    end
  end

  context 'when tags is empty' do
    let(:vacancy_payload) do
      {
        position: 'ruby developer',
        position_type: 'full_time',

        details_raw: 'test something here',

        location: 'moscow',
        remote_available: '1',

        salary: {
          min: '1_000_000',
          max: '222_222_222',
          currency: 'rub',
          unit: 'monthly'
        },

        archived_in_weeks: '2'
      }
    end

    it { expect(subject[:vacancy][:tags]).to eq([]) }
  end
end
