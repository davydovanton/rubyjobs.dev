# frozen_string_literal: true

# TODO: add specs
RSpec.describe Web::Controllers::Sitemap::Index, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(subject).to be_success }
end
