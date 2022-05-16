Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :password_resets, only: %i[new create edit update]
  root 'static_pages#top'

  resources :users, only: %i[new create]
  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resource :profile,only: %i[show edit update]

  get '/login' , to: 'user_sessions#new'
  post '/login' , to: 'user_sessions#create'
  delete '/logout' , to: 'user_sessions#destroy'

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_session#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
end
