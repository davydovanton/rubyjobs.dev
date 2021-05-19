# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.0'

gem 'bigdecimal', '1.4.2'
gem 'rake'

# http layer
gem 'hanami', '1.3.0'
gem 'puma', '~> 4.3.8'
gem 'xml-sitemap'

# persistance layer
gem 'hanami-model', '~> 1.3'
gem 'pg'
gem 'sequel', '~> 4.48.0'

# dependency managment
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'

# markdown
gem 'kramdown', '2.3.0'
gem 'kramdown-parser-gfm'
gem 'rinku'
gem 'rouge', '1.11.1'

# templates
gem 'sass'
gem 'sassc'

# Frontend
gem 'hanami-bootstrap'
gem 'jquery-hanami'
gem 'relative_time', github: 'davydovanton/relative_time', branch: 'master'
gem 'slim'

# auth
gem 'omniauth'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'web_bouncer',     github: 'davydovanton/web_bouncer'

# pagination
gem 'hanami-pagination', github: 'davydovanton/hanami-pagination'

# Monitoring and logging
gem 'rollbar'
gem 'semantic_logger'

# business logic section
gem 'dry-monads', '~> 1.1.0'

# background
gem 'hiredis'
gem 'sidekiq', ' ~> 5.2'
gem 'sidekiq-scheduler'

# notifications
gem 'telegram-bot-ruby'

# warnings
gem 'warning'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby

  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  # data generation and cleanup
  gem 'database_cleaner'
  gem 'hanami-fabrication'

  # style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec'

  # mutation testing
  gem 'mutant-rspec'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
  # gem 'puma'
end

group :plugins do
  gem 'hanami-operation-generator', github: 'davydovanton/hanami-operation-generator'
end
