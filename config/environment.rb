# frozen_string_literal: true

require 'warning'

Gem.path.each do |path|
  Warning.ignore(//, path)
end

Warning.ignore(/already initialized constant/)
Warning.ignore(/previous definition/)

Warning.ignore(/warning: The called method .+ is defined here/)

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'

# Disable warnings from dry-monads library.
# We have this warnings because use old version of validation with monad extension
Dry::Core::Deprecations.set_logger!(StringIO.new)

require_relative '../system/import'
require_relative './initializers/request_id'
require_relative '../apps/web/application'
require_relative '../apps/moderation/application'

Hanami.configure do
  middleware.use RequestId
  middleware.use Rack::Session::Cookie, secret: Container[:settings].web_sessions_secret

  mount Moderation::Application, at: '/moderation'
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/prices_api_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/prices_api_development'
    #    adapter :sql, 'mysql://localhost/prices_api_development'
    #
    adapter :sql, Container[:settings].database_url

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'

    # Use connection_validator sequel plugin for setup how often we need to check are connections
    # valid in connection pool or not. If connections invalod (DB instance was restarted) we will
    # reopen all connections again. In our case we will do it every 30 second or
    # `ENV['DATABASE_CONNECTION_VALIDATION_TIMEOUT']` seconds.
    # rubocop:disable Layout/LineLength
    gateway do |g|
      g.connection.extension(:connection_validator)
      g.connection.pool.connection_validation_timeout = Container[:settings].database_connection_validation_timeout || 30
    end
    # rubocop:enable Layout/LineLength
  end

  # See: http://hanamirb.org/guides/projects/logging
  logger Container[:logger]

  mailer do
    root 'lib/core/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
  end

  environment :production do
    mailer do
      delivery :test
    end
  end
end
