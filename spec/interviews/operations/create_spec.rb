# frozen_string_literal: true

RSpec.describe Interviews::Operations::Create, type: :operation do
  subject { operation.call(params) }

  let(:operation) do
    described_class.new(interview_repo: interview_repo, company_repo: company_repo)
  end

  let(:interview_repo) { instance_double('InterviewRepository', create_with_interview_rating: Interview.new) }
  let(:company_repo) { instance_double('CompanyRepository', update_interview_statistic: Company.new) }

  let(:params) do
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
    }
  end

  context 'when successful operation' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Interview) }

    it 'calls company statistic updater' do
      expect(company_repo).to receive(:update_interview_statistic).with(
          10,
          {
              author_id: 0,

              overall_impression: 3.0,
              recommendation: 3.0
          }
      )

      subject
      end
  end

  context 'when interview data is invalid' do
    let(:params) do
      {
        author_id: 1,
        body_raw: 'test text here',

        rating: {
          author_id: 0,

          overall_impression: 3.0,
          recommendation: 3.0
        }
      }
    end

    it { expect(subject).to be_failure }

    it do
      expect(subject.failure).to eq(anonymous: ['is missing'], company_id: ['is missing'], interview_rating: ['is missing'])
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:account_id) { Fabricate(:account).id }

    let(:params) do
      {
        author_id: account_id,
        company_id: Fabricate(:company).id,
        body_raw: 'test text here',
        anonymous: true,

        interview_rating: {
          author_id: account_id,

          overall_impression: 3.0,
          recommendation: 3.0
        }
      }
    end

    it { expect(subject).to be_success }
  end
end
