Rails.application.routes.draw do
  # namespace :admin do
  #   get 'users/index'
  #   get 'users/show'
  #   get 'users/edit'
  # end
  # namespace :admin do
  #   get 'post_images/index'
  #   get 'post_images/show'
  #   get 'post_images/edit'
  # end
  # namespace :admin do
  #   get 'homes/top'
  # end
  # namespace :public do
  #   get 'post_images/new'
  #   get 'post_images/index'
  #   get 'post_images/show'
  #   get 'post_images/edit'
  # end
  # namespace :public do
  #   get 'users/index'
  #   get 'users/show'
  #   get 'users/edit'
  #   get 'users/unsubscribe'
  # end
  # namespace :public do
  #   get 'homes/top'
  #   get 'homes/about'
  # end
# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# アドミン用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#ユーザーのルーティング
    root to: 'public/homes#top'
    get '/about' => 'public/homes#about', as: 'about'
    get 'users/show' => 'public/users#show' , as: 'show'
    get 'users/edit' => 'public/users#edit' , as: 'edit'
    get '/search' => 'searches#search', as: 'search'
    scope module: :public do
     resources :post_images, only: [:new, :create, :index, :show, :destroy]do
     resource :favorites, only: [:create, :destroy]
     resources :post_comments, only: [:create, :destroy]
  end
     resources :users, only: [:index,:show, :edit, :update] do
     collection do
          get 'unsubscribe'
          patch 'withdraw'
        end
        member do
      get :favorites
    end
      resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
 end
      resource :map, only: [:show]
    end
    #ゲストログイン機能のルーティング
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  #ゲストログイン機能ここまで

  # アドミンのルーティング
  namespace :admin do
    root to: 'homes#top'

    resources :users, only: [:index, :show, :edit, :update]

    resources :post_images, only: [:index, :show, :edit, :update, :destroy]do
    resources :post_comments, only: [ :destroy]
  end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end