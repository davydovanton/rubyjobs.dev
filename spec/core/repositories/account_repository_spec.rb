# frozen_string_literal: true

RSpec.describe AccountRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_github' do
    subject { repo.find_by_github(github_name) }

    before { Fabricate(:account, github: 'davydovanton') }

    context 'when account exists' do
      let(:github_name) { 'davydovanton' }

      it { expect(subject).to be_a Account }
    end

    context 'when account soes not exist' do
      let(:github_name) { 'notexist' }

      it { expect(subject).to be nil }
    end
  end
end
