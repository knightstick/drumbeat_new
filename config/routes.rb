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
  get "assign/:id" => 'users#assign_new_daily', as: 'assign_daily'
  get "assign_weekly/:id" => 'users#assign_new_weekly', as: 'assign_weekly'
  get "assign_monthly/:id" => 'users#assign_new_monthly', as: 'assign_monthly'
  post "assign/:id" => 'users#assign', as: 'assign'

  get "scorecards" => 'scorecards#index', as: 'scorecards'
  
  get "pick_new_daily" => "users#assign_new_daily", as: 'assign_new_daily'
  get "pick_new_weekly" => "users#assign_new_weekly", as: 'assign_new_weekly'
  get "pick_new_monthly" => "users#assign_new_monthly", as: 'assign_new_monthly'
  
  get "users/:user_id/scorecards/:id/reset" => "scorecards#reset", as: 'reset_scorecard'
  
  
  # get "/login" => "sessions#new"
  # post "/login" => "sessions#create"
  # get "/logout" => "sessions#destroy"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
