# frozen_string_literal: true

RSpec.describe Companies::Operations::Create, type: :operation do
  subject { operation.call(payload: company_payload) }

  let(:operation) do
    described_class.new(repo: company_repo)
  end

  let(:company_repo) do
    instance_double('CompanyRepository',
                    create: Company.new(company_payload),
                    already_exist?: already_exist)
  end

  let(:company_payload) do
    {
      name: 'Google',
      url: 'https://google.com'
    }
  end

  context 'when payload is valid' do
    context 'and company already exists' do
      let(:already_exist) { true }

      it { expect(subject).to be_failure }
    end

    context 'and company does not exist' do
      let(:already_exist) { false }

      it { expect(subject).to be_success }
    end
  end

  context 'when payload is invalid' do
    let(:company_payload) { {} }
    let(:already_exist) { false }

    it { expect(subject).to be_failure }
  end

  context 'with real dependencies' do
    subject { operation.call(payload: company_payload) }

    let(:operation) { described_class.new }

    before { Fabricate(:company, name: 'other') }

    it { expect(subject).to be_success }
  end
end
