Workspace::Application.routes.draw do
  root 'home#index'
  
  resources :exercises, only: [:index, :show]

  resources :users, except: [:index] do
    resources :scorecards, only: [:index, :show, :update]
  end



  get "logout" => "sessions#destroy", as: "logout"
  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  
  get "profile" => 'users#profile', as: 'profile'
  # get "assign/:id" => 'users#assign_new_daily', as: 'assign_daily'
  # get "assign_weekly/:id" => 'users#assign_new_weekly', as: 'assign_weekly'
  # get "assign_monthly/:id" => 'users#assign_new_monthly', as: 'assign_monthly'
  # post "assign/:id" => 'users#assign', as: 'assign'

  get "scorecards" => 'scorecards#index', as: 'scorecards'
  post "scorecards"=> 'scorecards#assign'
  
  # get "pick_new_daily" => "users#assign_new_daily", as: 'assign_new_daily'
  # get "pick_new_weekly" => "users#assign_new_weekly", as: 'assign_new_weekly'
  # get "pick_new_monthly" => "users#assign_new_monthly", as: 'assign_new_monthly'
  
  get "users/:user_id/scorecards/:id/reset" => "scorecards#reset", as: 'reset_scorecard'
end
