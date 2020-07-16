# frozen_string_literal: true

RSpec.describe Interviews::Operations::Create, type: :operation do
  subject { operation.call(params) }

  let(:operation) do
    described_class.new(interview_repo: interview_repo, company_repo: company_repo)
  end

  let(:interview_repo) { instance_double('InterviewRepository', create_with_interview_rating!: Interview.new) }
  let(:company_repo) { instance_double('CompanyRepository', update_statistic: Company.new) }

  let(:params) do
    {
        author_id: 0,
        company_id: 10,
        body_raw: 'test text here',
        anonymous: true,

        rating: {
            author_id: 0,

            overall_impression: 3.0,
            recommendation: 3.0,
        }
    }
    context 'when data is valid' do
      it { expect(subject).to be_success }
      it { expect(subject.value!).to be_a(Interview) }
      it 'calls company statistic updater' do
        expect(company_repo).to receive(:update_statistic).with(
            3,
            {
                author_id: 0,

                overall_impression: 3.0,
                recommendation: 3.0,
            }
        )

        subject
      end
    end
  end
end