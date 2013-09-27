Bitwin::Application.routes.draw do
  resources :trade_orders

  resources :users, :only => [] do
    collection do
      post 'sms_bind'
      post 'seed_sms_code'
      post 'solutions_sms_bind'
      put  'info_edit' => 'users#info_update', as: :info_update
      put  'real_name_authentication' => 'users#real_name_authentication', as: :real_name_auth
      post 'close_google_auth'
      get  'set_google_auth'
      post 'google_auth'
      put  'update' => 'users#update'
      post 'coin_tx'
    end
  end

  devise_for :users, :controllers => {
    registrations: "registrations",
    confirmations: 'confirmations'
  }

  root :to => "home#index"

  get "/account" => "users#account", as: :user_account
  get "/deals" => "users#deals", as: :user_deals
  get "/sigined_up" => "users#sigined_up", as: :sigined_up
  get "/email_confirmed" => "users#email_confirmed", as: :email_confirmed

  resources :user_mfa_session do
    collection do
      post 'authentic'
    end
  end

  resources :passwords do
    collection do
      get 'back/step1' => "passwords#step1", as: :back
      post 'back/step1' => "passwords#step1_post", as: :step1_post
      get 'back/step2' => "passwords#step2", as: :step2
      post 'back/step2' => "passwords#step2_post", as: :step2_post
    end
  end

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
