GeekCorps::Application.routes.draw do


  resources :languages
  resources :skills
  resources :roles
  resources :details

  resources :regions

  match 'apps' => 'apps#index', :as => 'apps'

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

  resources :teams do
  end

  put 'team_members/:id' => 'team_members#update', :as => 'team_member'

  resources :milestones
  resources :steps
  resources :deploy_task_resources

  post "comments/create"

  controller :teams do
    get '/:team_name' => :show
    get '/:team_name/people' => 'teams#people', :as => 'team_people'
    get '/:team_name/guide/' => 'milestones#index', :as => 'team_guide'
    controller :milestones do
      get '/:team_name/guide/milestone/:id/edit' => 'milestones#edit', :as => 'team_milestone_edit'      
      get '/:team_name/guide/milestone/new' => 'milestones#new', :as => 'team_milestone_new'      
      get '/:team_name/guide/milestone/:id' => 'milestones#show', :as => 'team_milestone'
      get '/:team_name/guide/milestone/:deploy_task_id/resources/new' => 'deploy_task_resources#new', :as => 'team_milestone_resource_new'      
    end
    controller :steps do
      get '/:team_name/guide/step/new' => 'steps#new', :as => 'team_step_new'
      get '/:team_name/guide/step/:id/edit' => 'steps#edit', :as => 'team_step_edit'      
      get '/:team_name/guide/step/:id' => 'steps#show', :as => 'team_step'
      get '/:team_name/guide/step/:deploy_task_id/resources/new' => 'deploy_task_resources#new', :as => 'team_step_resource_new'            
    end
  end

  get 'privacy' => 'pages#privacy'
  get 'about' => 'pages#about'
  get 'api' => 'pages#api'
  get 'blog' => 'pages#blog'
  get 'contact' => 'pages#contact'
  get 'terms' => 'pages#terms'

end
