Rails.application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
  resources :posts

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show]

  scope 'blog' do
    resources :posts
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  get '/beta-program' => 'beta_surveys#new'
  resources :beta_surveys, only: [:new, :create, :show]
  get '/beta-program/thank_you' => 'beta_surveys#thank_you'
  get '/current_customers' => redirect('https://www.boxbeestorage.com/simplestorage')
  get '/admin' => 'home#admin'

  #Legal
  get 'terms' => 'static_pages#terms'
  get 'privacy' => 'static_pages#terms'

  #External forwarders
  get '/instacart' => redirect('https://www.boxbeestorage.com/instacart')
  get '/simplestorage' => redirect('https://www.boxbeestorage.com/simplestorage')
  get '/jobs' => redirect('https://boxbee.workable.com')


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
