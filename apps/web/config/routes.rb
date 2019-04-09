root to: 'vacancies#index'

resources :vacancies, only: %i[new create show]

get '/terms', to: 'static#terms', as: :terms
get '/about', to: 'static#about', as: :about
get '/contacts', to: 'static#contacts', as: :contacts
