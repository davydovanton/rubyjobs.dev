# frozen_string_literal: true

RSpec.describe Interviews::Operations::List, type: :operation do
  subject { operation.call(company_id: 0) }

  let(:operation) do
    described_class.new(interview_repo: interview_repo)
  end

  context 'when company has interviews' do
    let(:interview_repo) { instance_double('InterviewRepository', all_for_companies: [Interview.new]) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Interview.new]) }
  end

  context 'when company does not have interview' do
    let(:interview_repo) { instance_double('InterviewRepository', all_for_companies: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    subject { operation.call(company_id: company_id) }

    let(:operation) { described_class.new }
    let(:company_id) { Fabricate(:company).id }

    before { Fabricate(:interview, company_id: company_id) }

    it { expect(subject).to be_success }
  end
end
