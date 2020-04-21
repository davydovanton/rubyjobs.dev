# frozen_string_literal: true

RSpec.describe Companies::Operations::List, type: :operation do
  subject { operation.call }

  let(:operation) do
    described_class.new(repo: company_repo)
  end

  let(:company_repo) { instance_double('CompanyRepository', all_with_reviews: []) }

  it { expect(subject).to be_success }
  it { expect(subject.value!).to eq([]) }

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    before { Fabricate(:company) }

    it { expect(subject).to be_success }
  end
end
