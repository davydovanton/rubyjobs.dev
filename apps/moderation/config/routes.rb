# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'dashboard#index'

resources :vacancy_approve, only: %i[update]
resources :vacancy_disapprove, only: %i[update]
