# frozen_string_literal: true

RSpec.describe Companies::Operations::Show, type: :operation do
  subject { operation.call(id: 0) }

  let(:operation) do
    described_class.new(repo: company_repo)
  end

  context 'when company exists' do
    let(:company_repo) { instance_double('CompanyRepository', find: Company.new(id: 0)) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq Company.new(id: 0) }
  end

  context 'when company is not exist' do
    let(:company_repo) { instance_double('CompanyRepository', find: nil) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq :not_found }
  end

  context 'with real dependencies' do
    subject { operation.call(id: company.id) }

    let(:operation) { described_class.new }

    let(:company) { Fabricate(:company) }

    it { expect(subject).to be_success }
  end
end
