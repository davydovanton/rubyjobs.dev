# frozen_string_literal: true

RSpec.describe Web::Mappers::ReviewForm, type: :mapper do
  subject { described_class.new.call(10, 0, params) }

  let(:search_options_hash) { {} }

  let(:params) do
    {
      body_raw: 'test text here',
      anonymous: 'true',

      rating: {
        salary_value: '3.0',
        office: '3.0',
        working_time: '3.0',
        project_interest: '3.0',
        atmosphere: '3.0',
        personal_growth: '3.0',
        modern_technologies: '3.0',
        management_level: '3.0',
        team_level: '3.0'
      }
    }
  end

  it do
    expect(subject).to eq(
      {
        author_id: 0,
        company_id: 10,
        body_raw: 'test text here',
        anonymous: true,

        rating: {
          author_id: 0,

          salary_value: 3.0,
          office: 3.0,
          working_time: 3.0,
          project_interest: 3.0,
          atmosphere: 3.0,
          personal_growth: 3.0,
          modern_technologies: 3.0,
          management_level: 3.0,
          team_level: 3.0
        }
      }
    )
  end

  context 'context for all anonymous cases' do
    [
      ['true', true],
      ['false', false],
      [nil, false],
      ['1', true],
      ['0', false],
      [1, true],
      [0, false]
    ].each do |raw_value, expectation|
      it do
        params = { anonymous: raw_value, rating: {} }
        result = described_class.new.call(10, 0, params)

        expect(result[:anonymous]).to eq(expectation)
      end
    end
  end
end
