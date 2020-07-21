# frozen_string_literal: true

RSpec.describe InterviewRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_companies' do
    subject { repo.all_for_companies(company_id) }

    context 'when company exists' do
      let(:company_id) { Fabricate(:company).id }

      context 'and company has interviews' do
        before do
          Fabricate(:interview, company_id: company_id)
        end

        it 'returns list of interviews with author information' do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(Interview)
          expect(subject.first.author).to be_a(Account)
        end
      end

      context 'and company does not have interviews' do
        it { expect(subject).to eq([]) }
      end
    end

    context 'when company does not exist' do
      let(:company_id) { 0 }

      it { expect(subject).to eq([]) }
    end
  end

  describe '#create_with_interview_rating!' do
    subject { repo.create_with_interview_rating!(**interview_payload, interview_rating: interview_rating_payload) }

    let(:account) { Fabricate(:account) }
    let(:company) { Fabricate(:company) }

    let(:interview_payload) do
      {
          author_id: account.id,
          company_id: company.id,

          body_raw: 'test text here',
          body: 'test text here',

          anonymous: true
      }
    end

    let(:interview_rating_payload) do
      {
          author_id: account.id,

          overall_impression: 3.0,
          recommendation: 3.0,
      }
    end

    context 'when data is valid' do
      it { expect(subject).to be_a Interview }
    end

    context 'when interview data is invalid' do
      let(:interview_payload) { { account_id: account.id, anonymous: true } }

      it { expect { subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end

    context 'when interview_rating data is invalid' do
      let(:interview_rating_payload) { { account_id: account.id, anonymous: true } }

      it { expect { subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end
  end
end
