# frozen_string_literal: true

RSpec.describe Reviews::Operations::List, type: :operation do
  subject { operation.call(company_id: 0) }

  let(:operation) do
    described_class.new(review_repo: review_repo)
  end

  context 'when company has reviews' do
    let(:review_repo) { instance_double('ReviewRepository', all_for_companies: [Review.new]) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Review.new]) }
  end

  context 'when company does not have reviews' do
    let(:review_repo) { instance_double('ReviewRepository', all_for_companies: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    subject { operation.call(company_id: company_id) }

    let(:operation) { described_class.new }
    let(:company_id) { Fabricate(:company).id }

    before { Fabricate(:review, company_id: company_id) }

    it { expect(subject).to be_success }
  end
end
