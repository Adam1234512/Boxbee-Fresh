Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show]

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
  get '/boxbutler' => redirect('https://www.boxbeestorage.com/boxbutler')
end
