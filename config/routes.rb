Workspace::Application.routes.draw do
  root 'home#index'
  
  resources :exercises, only: [:index, :show]

  resources :users, except: [:index]  # do
    # resources :scorecards, only: [:index, :show, :update]
  # end

  get "logout" => "sessions#destroy", as: "logout"
  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  
  get "profile" => 'users#profile', as: 'profile'

  get 'me/scorecards' => 'scorecards#index', as: 'scorecards'
  get 'me/scorecards/:id' => 'scorecards#show', as: 'scorecard'
  patch 'me/scorecards/:id' => 'scorecards#update', as: 'update_scorecard'

  # get "scorecards" => 'scorecards#index', as: 'scorecards'
  # post "scorecards"=> 'scorecards#assign'
  
  # get "users/:user_id/scorecards/:id/reset" => "scorecards#reset", as: 'reset_scorecard'
end
