# frozen_string_literal: true

RSpec.describe CompanyRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#already_exist?' do
    subject { repo.already_exist?(company) }

    before { Fabricate(:company, name: 'Google') }

    context 'when name contain other case' do
      let(:company) { Company.new(name: 'googLe') }

      it { expect(subject).to be true }
    end

    context 'when name is absolute same' do
      let(:company) { Company.new(name: 'Google') }

      it { expect(subject).to be true }
    end

    context 'when name contains space' do
      let(:company) { Company.new(name: 'g oogle') }

      it { expect(subject).to be true }
    end

    context 'when name contains trim chars' do
      let(:company) { Company.new(name: ' google ') }

      it { expect(subject).to be true }
    end

    context 'when name is different' do
      let(:company) { Company.new(name: 'other') }

      it { expect(subject).to be false }
    end
  end
end
