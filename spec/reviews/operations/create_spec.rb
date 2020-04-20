# frozen_string_literal: true

RSpec.describe Reviews::Operations::Create, type: :operation do
  let(:operation) do
    described_class.new(review_repo: review_repo, company_repo: company_repo)
  end

  let(:review_repo) { instance_double('ReviewRepository', create_with_rating!: Review.new) }
  let(:company_repo) { instance_double('CompanyRepository', update_statistic: Company.new) }

  subject { operation.call(params) }

  let(:params) do
    {
      author_id: 0,
      company_id: 10,
      body_raw: "test text here",
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
  end

  context 'when data is valid' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Review) }

    it 'calls company statistic updater' do
      expect(company_repo).to receive(:update_statistic).with(
        10,
        {
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
      )

      subject
    end
  end

  context 'when review data is invalid' do
    let(:params) do
      {
        author_id: 1,
        body_raw: "test text here",

        rating: {
          author_id: 0,

          salary_value: 3.0,
          working_time: 3.0,
          project_interest: 3.0,
          atmosphere: 3.0,
          personal_growth: 3.0,
          modern_technologies: 3.0,
          management_level: 3.0,
          team_level: 3.0
        }
      }
    end

    it { expect(subject).to be_failure }
    it do
      expect(subject.failure).to eq(
        anonymous: ["is missing"], company_id: ["is missing"], rating: { office: ["is missing"] }
      )
    end
  end


  context 'with real dependencies' do
    let(:operation) { described_class.new }

    let(:params) do
      account_id = Fabricate(:account).id
      {
        author_id: account_id,
        company_id: Fabricate(:company).id,
        body_raw: "test text here",
        anonymous: true,

        rating: {
          author_id: account_id,

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
    end

    it { expect(subject).to be_success }
  end
end
