# frozen_string_literal: true

require './config/environment'

use Rack::Session::Cookie, secret: ENV['WEB_SESSIONS_SECRET']
run Hanami.app
