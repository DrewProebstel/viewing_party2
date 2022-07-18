Rails.application.routes.draw do
  get '/register', to: 'login#create'
  get '/', to: 'landing#index'
  get '/users/register', to: 'users#new'
  get '/users/:id/discover', to: 'discover#index'
  get '/users/:id', to: 'users#show'
  post '/users/register', to: 'users#create'

  get '/users/:id/movies', to: 'movies#index'
  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  get '/users/:id/movies/:movie_id', to: 'movies#show'
  post '/users/:id/movies/:movie_id', to: 'viewing_parties#create'
end
