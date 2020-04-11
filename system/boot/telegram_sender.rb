# frozen_string_literal: true

require 'telegram/bot'
# https://t.me/rubyjobs_dev_moderation

class TelegramSender
  include Dry::Monads::Task::Mixin

  attr_reader :bot, :logger

  def initialize(token:, logger:)
    @bot = Telegram::Bot::Client.new(token, logger: logger)
  end

  def call(chat_id, message)
    bot.api.send_message(chat_id: chat_id, text: message)
  end
end

Container.boot(:telegram_sender) do |container|
  use :settings
  use :logger

  init do
    sender = TelegramSender.new(token: container[:settings].telegram_bot_token, logger: container['logger'])
    container.register('libs.telegram_sender', sender)
  end
end
