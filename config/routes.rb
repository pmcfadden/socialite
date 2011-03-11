Socialite::Application.routes.draw do
  devise_for :users

  match 'submissions/:id/vote_up', :to => 'submissions#vote_up', :via => "post", :defaults => { :format => 'js'}, :as => 'vote_up'
  match 'about', :to => "application#about", :via => "get", :as => 'about'

  get 'admin', :to => "admin#index", :as => 'admin'
  match 'admin/moderate_submissions', :to => "admin#moderate_submissions", :via => "get", :as => 'moderate_submissions'
  match 'admin/mark_as_spam', :to => "admin#mark_as_spam", :as => 'mark_as_spam'

  scope "/admin" do
    resources :users
  end

  resources :submissions
  resources :comments

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
  root :to => "submissions#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
