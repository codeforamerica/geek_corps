GeekCorps::Application.routes.draw do 

  resources :details

  resources :teams do
    resources :members
  end

  resources :regions

  resources :apps do
    resources :teams
  end

  root :to => "people#index"

  resources :authentications

  resources :people do
    collection do
      get 'grid', :action => :index, :grid => '1'
    end
    member do
      get 'claim'
      get 'photo'
    end
  end
  get '/people/tag/:tag(.:format)' => 'people#tag', :as => 'people_tagged', :constraints => {:tag => /.*/}

  resources :users, :only => [:show, :index, :destroy] do
    member do
      post 'adminify'
    end
  end
  get '/welcome' => 'users#welcome', :as => 'welcome_users'
  get '/home' => 'users#home', :as => 'home_users'

  resources :user_sessions, :only => [:new, :create], :controller => 'users/sessions'

  devise_for :users do
    get "/sign_out" => "devise/sessions#destroy"
    get "/sign_in" => "users/sessions#new"
  end

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/auto' => 'authentications#auto'
  match '/auth/failure' => 'authentications#auth_failure'
  match '/:team_name' => 'teams#show'

  get 'privacy' => 'pages#privacy'
  get 'about' => 'pages#about'
  get 'api' => 'pages#api'
  get 'blog' => 'pages#blog'
  get 'contact' => 'pages#contact'
  get 'terms' => 'pages#terms'

end
