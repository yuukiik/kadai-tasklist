Rails.application.routes.draw do

    root to: 'tasks#index'
    
    # ユーザー登録
    get 'signup', to: 'users#new'
    
    # ログイン
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    
    resources :users, only: [:new, :create]
    
    resources :tasks
end
