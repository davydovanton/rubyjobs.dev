# frozen_string_literal: true

RSpec.describe Web::Controllers::Static::Contacts, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(subject).to be_success }
end
