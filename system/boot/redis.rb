# typed: ignore
# frozen_string_literal: true

Container.boot(:redis) do |container|
  init do
    uri = URI.parse(ENV.fetch('REDISTOGO_URL', ''))
    redis = ConnectionPool.new(size: 10, timeout: 3) do
      Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password)
    end

    # ping redis DB before start for understanding that all works correctly
    redis.with(&:ping)

    container.register('persistance.redis', redis)
  end
end
