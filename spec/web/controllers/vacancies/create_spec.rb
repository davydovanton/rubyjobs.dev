RSpec.describe Web::Controllers::Vacancies::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  subject { action.call(params) }

  it { expect(subject).to be_success }
end
