# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'
require_relative '../lib/types'
require_relative '../lib/core/libs/operation'
require_relative './core_ext'

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  # use :bootsnap
  use :env

  #  Core
  register_folder! 'core/repositories'
  register_folder! 'core/libs'

  #  Analitics
  register_folder! 'analitics/operations'

  #  Vacancies
  register_folder! 'vacancies/mappers'
  register_folder! 'vacancies/queries'
  register_folder! 'vacancies/operations'

  # Subscribers
  register_folder! 'subscribers/operations'

  # Companies
  register_folder! 'companies/operations'

  #  Web
  namespace 'web' do
    register 'vacancies.generators.rss' do
      Web::Views::RssFeed::Generator.new
    end

    register 'mappers.search_options' do
      Web::Mappers::SearchOptions.new
    end
  end

  configure do |config|
    config.env = Hanami.env
  end
end

Container.register(:current_time) { -> { Time.now } }
