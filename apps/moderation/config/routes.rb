# frozen_string_literal: true

root to: 'dashboard#index'

resources :vacancy_approve, only: %i[update]
resources :vacancy_disapprove, only: %i[update]
