Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root "games#index"

  resources :games, :only => [:index, :create, :new, :show] do
    resources :guesses, :only => [:new, :create]
  end

  resources :clues, :only => [:create, :update]
end
