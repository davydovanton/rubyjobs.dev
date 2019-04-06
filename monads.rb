require './config/environment'
require 'dry/monads/maybe'
require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/monads/do'

include Dry::Monads::Maybe::Mixin
include Dry::Monads::Result::Mixin
include Dry::Monads::Try::Mixin

class User
end


class Service
  include Dry::Monads::Do.for(:call)

  def call(params)
    values = yield validate(params)
    account = yield create_account(values[:account])
    owner = yield create_owner(account, values[:owner])

    Success([account, owner])
  end

  def validate(params)
    # Success(params)
    Failure(:invalid)
  end

  def create_account(account_values)
    Success(:account)
  end

  def create_owner(account, owner_values)
    Success(:owner)
  end
end

p Service.new.call(account: {}, owner: {}) # => Result object
