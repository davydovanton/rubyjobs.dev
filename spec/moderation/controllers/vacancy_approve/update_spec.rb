# frozen_string_literal: true

RSpec.describe Moderation::Controllers::VacancyApprove::Update, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
