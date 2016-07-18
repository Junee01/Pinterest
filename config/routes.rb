Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :pins do
    collection do
      get 'search'
    end
    member do
      put "like", to: "pins#upvote"
    end
    resources :comments
  end
  root "pins#index"
end