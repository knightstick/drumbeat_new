Workspace::Application.routes.draw do
  get 'regime/create'

  get 'regime/show'

  get 'regime/update'

  get 'regime/destroy'

  root 'home#index'
  
  resources :exercises, only: [:index, :show]

  resources :users, except: [:index]  # do
    # resources :scorecards, only: [:index, :show, :update]
  # end

  get "logout" => "sessions#destroy", as: "logout"
  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  
  get "me" => 'users#profile', as: 'profile'
  get 'me/practice' => 'users#practice', as: 'practice_room'
  get 'me/regime' => 'regime#show', as: 'regime'
  post 'me/regime' => 'regime#create', as: 'create_regime'

  get 'me/scorecards' => 'scorecards#index', as: 'scorecards'
  get 'me/scorecards/:id' => 'scorecards#show', as: 'scorecard'
  patch 'me/scorecards/:id' => 'scorecards#update', as: 'update_scorecard'
  post 'me/scorecards/:id/reset' => 'scorecards#reset', as: 'reset_scorecard'
  post 'me/scorecards' => 'scorecards#assign', as: 'create_scorecards'

  # get "scorecards" => 'scorecards#index', as: 'scorecards'
  # post "scorecards"=> 'scorecards#assign'
  
  # get "users/:user_id/scorecards/:id/reset" => "scorecards#reset", as: 'reset_scorecard'
end
