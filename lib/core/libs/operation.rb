# frozen_string_literal: true

require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/monads/do'
require 'dry/monads/do/all'

module Libs
  # Base operation class. Provides dry-monads do notation and Result monads.
  #
  # @api private
  #
  # @see http://dry-rb.org/gems/dry-monads/1.0/result/ Result monad documentation
  # @see http://dry-rb.org/gems/dry-monads/1.0/do-notation/ Do notation documentation
  #
  # @example
  #
  #   module Operations
  #     class Read < Libs::Operation
  #       def call(payload)
  #         payload = yield Success(payload)
  #         Success(payload)
  #       end
  #     end
  #   end
  #
  #   Operations::Read.new.call(a: 1) # => Success(a: 1)
  class Operation
    include Dry::Monads::Try::Mixin
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do::All

    Dry::Validation.load_extensions(:monads)

    def call(*)
      raise NotImplementedError
    end
  end
end
