# frozen_string_literal: true

RSpec.describe Web::Controllers::Reviews::Create, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }

  let(:session) { { account: account } }
  let(:account) { Account.new(id: 1) }

  let(:params) do
    {
      'rack.session' => session,
      review: {
        account_id: '1',
        body_raw: 'test text here',
        anonymous: 'true',

        rating: {
          salary_value: '3.0',
          office: '3.0',
          working_time: '3.0',
          project_interest: '3.0',
          atmosphere: '3.0',
          personal_growth: '3.0',
          modern_technologies: '3.0',
          management_level: '3.0',
          team_level: '3.0'
        }
      },
      company_id: company_id
    }
  end

  let(:company_id) { '1' }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }
    let(:success_flash) { 'Отзыв успешно создан.' }

    it { expect(subject).to redirect_to '/companies/1' }

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:success]).to eq(success_flash)
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(:error) } }
    let(:flash_message) { 'Произошла ошибка, пожалуйста повторите позже' }

    it { expect(subject).to redirect_to '/companies/1' }

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:fail]).to eq(flash_message)
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:account) { Fabricate(:account) }
    let(:company_id) { Fabricate(:company).id }
    let(:action) { described_class.new }

    it { expect(subject).to redirect_to "/companies/#{company_id}" }
  end
end
