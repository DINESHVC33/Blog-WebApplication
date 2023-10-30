Rails.application.routes.draw do

  devise_for :users
  get'/posts' , to: 'posts#all_posts' , as: 'all_posts'
  resources :topics do
    resources :posts do
      resources :comments
      resources :ratings, only: [:create]
    end
  end
  resources :tags do
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
