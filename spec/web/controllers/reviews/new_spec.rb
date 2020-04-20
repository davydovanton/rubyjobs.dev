# frozen_string_literal: true

RSpec.describe Web::Controllers::Reviews::New, type: :action do
  let(:action) { described_class.new }
  let(:session) { { account: Account.new(id: 1) } }
  let(:params) { { 'rack.session' => session } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
