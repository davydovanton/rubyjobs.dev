root to: 'vacancies#index'

resources :vacancies, only: %i[new create show]

get '/terms', to: 'static#terms'
get '/about', to: 'static#about'
get '/contacts', to: 'static#contacts'
