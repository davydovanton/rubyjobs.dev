# frozen_string_literal: true

# Simple middleware for generating request id and tagged logger for this value
class RequestId
  FORM_HASH = 'rack.request.form_hash'

  # Constructor method for request id rack middleware
  #
  # @param [App] app rack app
  # @param [SemanticLogger::Logger] logger logger instance
  def initialize(app, logger: Container[:logger], rollbar: Container[:rollbar])
    @app = app
    @logger = logger
    @rollbar = rollbar
  end

  # Tag all logger calls with request id information
  #
  # @param [Hash] env rack env
  def call(env)
    env['request_id'] = SecureRandom.hex
    env[FORM_HASH] ||= {}
    env[FORM_HASH]['request_id'] = env['request_id']

    @logger.tagged(requires_id: env['request_id']) do
      @app.call(env)
    end
  end
end
