root to: 'vacancies#index'

resources :vacancies, only: %i[new create show]

get '/terms', to: 'static#terms', as: :terms
get '/about', to: 'static#about', as: :about
get '/contacts', to: 'static#contacts', as: :contacts
get '/.well-known/acme-challenge/26ZMu5hIuUyL_OOlI1A2tFx7eYQQtmu95Wk0XqnN_f0', to: ->(env) { [200, {}, ['26ZMu5hIuUyL_OOlI1A2tFx7eYQQtmu95Wk0XqnN_f0.Pykxyeexf4KnPKQPSOt5yVGIhi0eu0Jot6rWiqmKo_8!']] }
get '/.well-known/acme-challenge/ycXBKexc1zDYeQVQ-YGRP7bbhVNjKcuiUshM3NBgP-o', to: ->(env) { [200, {}, ['ycXBKexc1zDYeQVQ-YGRP7bbhVNjKcuiUshM3NBgP-o.Pykxyeexf4KnPKQPSOt5yVGIhi0eu0Jot6rWiqmKo_8']] }
