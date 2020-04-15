# frozen_string_literal: true

class SubscriberRepository < Hanami::Repository
  def find_by_email(email)
    root.where(email: email).map_to(Subscriber).one
  end
end
