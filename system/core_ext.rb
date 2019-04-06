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
