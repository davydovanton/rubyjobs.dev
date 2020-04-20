# frozen_string_literal: true

require_relative './oauth/github_callback'

class WebBouncer::OauthContainer # rubocop:disable Style/ClassAndModuleChildren
  register 'oauth.github_callback', Auth::Oauth::GithubCallback
end
