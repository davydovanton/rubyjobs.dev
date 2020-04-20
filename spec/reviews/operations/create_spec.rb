# frozen_string_literal: true

RSpec.describe Reviews::Operations::Create, type: :operation do
  subject { operation.call }

  let(:params) do
    {
      review: {
        account_id: "1",
        body_raw:"test text here",
        anonymous: "true",

        rating: {
          salary_value: "3.0",
          office: "3.0",
          working_time: "3.0",
          project_interest: "3.0",
          atmosphere: "3.0",
          personal_growth: "3.0",
          modern_technologies: "3.0",
          management_level: "3.0",
          team_level:"3.0"
        },
      },
      company_id: "1"
    }
  end

  let(:operation) do
    described_class.new
  end

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
