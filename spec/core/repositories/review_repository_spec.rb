# frozen_string_literal: true

RSpec.describe ReviewRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#create_with_rating!' do
    subject { repo.create_with_rating!(**review_payload, rating: rating_payload) }

    let(:account) { Fabricate(:account) }
    let(:company) { Fabricate(:company) }

    let(:review_payload) do
      {
        author_id: account.id,
        company_id: company.id,

        body_raw: "test text here",
        body: "test text here",

        anonymous: true
      }
    end

    let(:rating_payload) do
      {
        author_id: account.id,

        salary_value: 3.0,
        office: 3.0,
        working_time: 3.0,
        project_interest: 3.0,
        atmosphere: 3.0,
        personal_growth: 3.0,
        modern_technologies: 3.0,
        management_level: 3.0,
        team_level:3.0
      }
    end

    context 'when data is valid' do
      it { expect(subject).to be_a Review }
    end

    context 'when review data is invalid' do
      let(:review_payload) { { account_id: account.id, anonymous: true } }

      it { expect{ subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end

    context 'when rating data is invalid' do
      let(:rating_payload) { { account_id: account.id, anonymous: true } }

      it { expect{ subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end
  end
end

