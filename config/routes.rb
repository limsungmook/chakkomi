Chakkomi::Application.routes.draw do
  resources :item_categories

  devise_for :users, :controllers => { :registrations => "users/registrations" }

#  root :to => "articles#show"
  root :to => "articles#intro"
  resources :orders do
    collection do
      get :zipsearch
    end
  end
  resources :admins do
    collection do
      get :order_list
    end
  end
  resources :accounts
  resources :line_items
  resources :store do
    collection do
      get :detail
    end
  end
  resources :carts
  resources :products
  resources :product_options
  resources :categories
  resources :posts 
  resources :articles do
    collection do
      get :notice
      get :chakkomi
      get :project
      get :comics
      get :product
    end
  end


  resources :talks do
    collection do
      get :check_update
      get :check_update_relay

    end
    resources :relays
  end
  
  match '/auth/:service/callback' => 'services#create' 
  match '/auth/failure' => 'services#failure'
  resources :services, :only => [:index, :create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
