# frozen_string_literal: true

require './config/environment'
require 'web_bouncer'
require 'web_bouncer/oauth_middleware'
require './lib/auth/oauth_container'

use Rack::Session::Cookie, secret: Container[:settings].web_sessions_secret

use OmniAuth::Builder do
  provider :github, Container[:settings].github_key, Container[:settings].github_secret, provider_ignores_state: true
end

use WebBouncer['middleware.oauth'], model: :account, login_redirect: '/companies'
run Hanami.app
