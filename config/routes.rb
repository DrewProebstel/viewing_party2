Rails.application.routes.draw do
  get '/', to: 'landing#index'
  get '/users/register', to: 'users#new'
  get '/users/discover', to: 'discover#index'
  get '/users', to: 'users#show'
  post '/users/register', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  get '/users/:id/movies', to: 'movies#index'
  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  get '/users/:id/movies/:movie_id', to: 'movies#show'
  post '/users/:id/movies/:movie_id', to: 'viewing_parties#create'
end
