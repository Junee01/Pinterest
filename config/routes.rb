Rails.application.routes.draw do
  resources :comments
  devise_for :users
  #pins는 search로 검색이 가능하고
  resources :pins do
    collection do
      get 'search'
    end
    #각각의 memeber는 like로 pins#upvote에 +1이 추가할 수 있습니다.
    member do
      put "like", to: "pins#upvote"
    end
    #각각의 pins에서는 그 pin은 comment로 이동이 가능합니다.
    resources :comments
  end
  #첫 페이지를 pins#index로 합니다.
  root "pins#index"
end