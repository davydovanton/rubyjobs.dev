# frozen_string_literal: true

RSpec.describe ReviewRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_companies' do
    subject { repo.all_for_companies(company_id) }

    context 'when company exists' do
      let(:company_id) { Fabricate(:company).id }

      context 'and company has reviews' do
        before do
          Fabricate(:review, company_id: company_id)
        end

        it 'returns list of reviews with author information' do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(Review)
          expect(subject.first.author).to be_a(Account)
        end
      end

      context 'and company does not have reviews' do
        it { expect(subject).to eq([]) }
      end
    end

    context 'when company does not exist' do
      let(:company_id) { 0 }

      it { expect(subject).to eq([]) }
    end
  end

  describe '#create_with_rating!' do
    subject { repo.create_with_rating!(**review_payload, rating: rating_payload) }

    let(:account) { Fabricate(:account) }
    let(:company) { Fabricate(:company) }

    let(:review_payload) do
      {
        author_id: account.id,
        company_id: company.id,

        body_raw: 'test text here',
        body: 'test text here',

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
        team_level: 3.0
      }
    end

    context 'when data is valid' do
      it { expect(subject).to be_a Review }
    end

    context 'when review data is invalid' do
      let(:review_payload) { { account_id: account.id, anonymous: true } }

      it { expect { subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end

    context 'when rating data is invalid' do
      let(:rating_payload) { { account_id: account.id, anonymous: true } }

      it { expect { subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end
  end
end
