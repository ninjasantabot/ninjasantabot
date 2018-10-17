Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', :to => redirect('/login')
  get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	delete '/logout' => 'sessions#destroy'

  resources :users, :only => [:create, :new]

  resources :sessions, :only => [:create, :new]

  resources :games, :only => [:index, :create, :new, :show]

  resources :guesses, :only => [:new, :create]

  resources :clues, :only => [:create, :update]
end
