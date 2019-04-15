# frozen_string_literal: true

module Vacancies
  module Workers
    class VacanciesArchivator
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[]

      def perform
        puts 'HELLO'
      end
    end
  end
end
