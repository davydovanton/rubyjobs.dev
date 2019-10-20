# frozen_string_literal: true

module Hanami
  # Registered components
  #
  # @since 0.9.0
  # @api private
  #
  # @see Hanami::Components
  module Components
    # Setup project's logger
    #
    # @since 1.0.0
    # @api private
    register 'logger' do
      resolve { |configuration| configuration.logger.first }
    end
  end
end

module Sequel
  module Deprecation
    def self.deprecate(method, instead = nil) # rubocop:disable Lint/UnusedMethodArgument
      nil
    end
  end
end
