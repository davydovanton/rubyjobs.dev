# frozen_string_literal: true

Container.boot(:rollbar) do |container|
  init do
    require 'rollbar'

    Rollbar.configure do |config|
      config.disable_rack_monkey_patch = true
      config.access_token = ENV['ROLLBAR_KEY']
    end

    # Rollbar.info('new')

    container.register(:rollbar, Rollbar)
  end
end
