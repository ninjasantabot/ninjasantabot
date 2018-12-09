Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root "games#index"

  resources :games, only: %i(index create new show) do
    member do
      post :join
    end
    resources :clues, only: %i(new create edit update)
    resources :guesses, only: %i(new create)
    resource  :leaderboard, only: %i(show)
  end

end
