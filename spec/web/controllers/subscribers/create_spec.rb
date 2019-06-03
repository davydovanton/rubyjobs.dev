# frozen_string_literal: true

RSpec.describe Web::Controllers::Subscribers::Create, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success(Vacancy.new(id: 123)) } }

  let(:params) { { subscriber: { email: 'test@email.com' } } }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(Subscriber.new(email: 'test@email.com', id: 123)) } }
    let(:flash_message) { 'test@email.com успешно добавлен в рассылку.' }

    it { expect(subject).to redirect_to '/' }

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:success]).to eq(flash_message)
    end
  end

  context 'when invalid email' do
    let(:params) { { subscriber: { email: 'email.com' } } }
    let(:flash_message) { 'Не валидная почта "email.com".' }
    let(:operation) { ->(*) { Failure(:error) } }

    it { expect(subject).to redirect_to '/' }

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:error]).to eq(flash_message)
    end
  end

  context 'when operation returns failure result' do
    let(:flash_message) { 'Произошла ошибка, попробуйте позже или используйте другой почтовый адресс.' }
    let(:operation) { ->(*) { Failure(Hanami::Model::UniqueConstraintViolationError.new) } }

    it { expect(subject).to redirect_to '/' }

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:error]).to eq(flash_message)
    end
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    it { expect(subject).to redirect_to '/' }
  end
end
