# typed: ignore
# frozen_string_literal: true

require 'rss'
require 'hanami/helpers/escape_helper'

module Web
  module Views
    module RssFeed
      class Generator
        include Hanami::Helpers::EscapeHelper

        attr_reader :current_time

        def initialize(current_time: -> { Time.now })
          @current_time = current_time
        end

        def call(vacancies:) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          rss = RSS::Maker.make('atom') do |maker|
            maker.channel.author = 'RubyJobs'
            maker.channel.updated = current_time.call
            maker.channel.about = 'https://rubyjobs.dev/feed.rss'
            maker.channel.title = 'Ruby Jobs RSS feed'

            vacancies.each do |vacancy|
              maker.items.new_item do |item|
                item.link = "https://rubyjobs.dev/vacancies/#{vacancy.id}"
                item.title = vacancy.position
                item.updated = vacancy.updated_at.to_s
                item.description = vacancy.details
              end
            end
          end

          raw(rss.to_s)
        end
      end
    end
  end
end
