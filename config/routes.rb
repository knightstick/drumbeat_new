Workspace::Application.routes.draw do
  root 'home#index'
  
  resources :exercises, only: [:index, :show]

  resources :users, only: [:create, :show]

  get "logout" => "sessions#destroy", as: "logout"
  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"

  get "me" => 'users#profile', as: 'profile'

  get 'me/routine' => 'routines#show', as: 'routine'
  post 'me/routine' => 'routines#create'
  patch 'me/routine' => 'routines#update'
  
  get 'me/scorecards' => 'scorecards#index', as: 'scorecards'
  get 'me/scorecards/:id' => 'scorecards#show', as: 'scorecard'
  patch 'me/scorecards/:id' => 'scorecards#update', as: 'update_scorecard'
  post 'me/scorecards/:id/reset' => 'scorecards#reset', as: 'reset_scorecard'
  post 'me/scorecards' => 'scorecards#assign', as: 'create_scorecards'

  # get "scorecards" => 'scorecards#index', as: 'scorecards'
  # post "scorecards"=> 'scorecards#assign'
  
  # get "users/:user_id/scorecards/:id/reset" => "scorecards#reset", as: 'reset_scorecard'
end
