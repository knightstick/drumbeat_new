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
  get 'me/scorecards/random' => 'scorecards#random', as: 'random_scorecard'
  post 'me/scorecards/:id/reset' => 'scorecards#reset', as: 'reset_scorecard'


  scope '/me' do 
    resources :routines, only: [:create, :update]
    resources :scorecards, only: [:index, :show, :update, :create] 
  end  
end
