Rails.application.routes.draw do
  root 'pictures#index'
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  resources :favorites, only: [:index, :create, :destroy]
end
