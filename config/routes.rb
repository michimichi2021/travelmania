Rails.application.routes.draw do
  devise_for :users,controllers:{
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
  }
  
  devise_for :admins,controllers:{
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :areas, only: [:index, :create, :edit, :update, :destroy]
    resources :genres,only: [:index, :create, :edit, :update, :destroy]
    resources :scenes,only: [:index, :create, :edit, :update, :destroy]
  end
  
  scope module: :public do
    root to: 'homes#top'
    resources :users, only: [:show, :edit ,:update] do
      member do
        get :favorites
        get :follows
        get :followers
      end
      collection do
        get :unsubscribe
        patch :withdraw
      end
      resource :relationships, only: [:create, :destroy]
    end
    
    resources :posts, only: [:new, :create, :show, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
      collection do
        get :search
      end
    end
    
    resources :notifications, only:[:index, :destroy] do
      collection do
        delete :destroy_all
      end
    end
    
    resources :chats, only:[:show,:create, :index]
    
  end
 
end
