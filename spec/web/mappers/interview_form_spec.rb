# frozen_string_literal: true

RSpec.describe Web::Mappers::InterviewForm, type: :mapper do
  subject { described_class.new.call({company_id: 10, account_id: 0, interview: params}) }

  let(:search_options_hash) { {} }

  let(:params) do
    {
      body_raw: 'test text here',
      anonymous: 'true',

      interview_rating: {
        overall_impression: '3.0',
        recommendation: '3.0'
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

        interview_rating: {
          author_id: 0,

          overall_impression: 3.0,
          recommendation: 3.0
         }
      })
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
        params = { anonymous: raw_value, interview_rating: {} }
        result = described_class.new.call({company_id: 10, account_id: 0, interview: params})

        expect(result[:anonymous]).to eq(expectation)
      end
    end
  end
end

