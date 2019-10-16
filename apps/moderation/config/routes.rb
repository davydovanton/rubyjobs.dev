# frozen_string_literal: true

root to: 'dashboard#index'

get 'vacancy/:id', to: 'dashboard#show'

resources :vacancy_approve, only: %i[update]
resources :vacancy_disapprove, only: %i[update]
