# frozen_string_literal: true

RSpec.describe Companies::Operations::ShowByName, type: :operation do
  subject { operation.call(name: 'test') }

  let(:operation) do
    described_class.new(repo: company_repo)
  end

  let(:company_repo) { instance_double('CompanyRepository', find_by_name: company) }

  context 'when company exists' do
    let(:company) { Company.new(id: 0) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Company) }
  end

  context 'when company does not exist' do
    let(:company) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
  end

  context 'with real dependencies' do
    subject { operation.call(name: 'test') }

    let(:operation) { described_class.new }

    before { Fabricate(:company, name: ' tes t') }

    it { expect(subject).to be_success }
  end
end
