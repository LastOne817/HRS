Rails.application.routes.draw do
    get'/auth/:provider/callback' => 'sessions#auth'
    get '/login', to: 'sessions#find', :as => :login
    get '/signin', to: 'sessions#new', :as => :signin
    get '/logout', to: 'sessions#destroy', :as => :logout
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'pages#index'
    get 'pages/main'
    get 'pages/checklist'
    get 'pages/login'
    get 'pages/signup'
    get 'pages/profile'
    get 'pages/wiki'
    post 'pages/result'
    get 'pages/hobbylist'
    post 'pages/showliked'
    get 'pages/showliked'
    post 'pages/showdisliked'
    get 'pages/showdisliked'
    post 'pages/deletefromlist'
    post 'pages/setlike'

    post 'users/signup', to: 'users#signup'
    post 'users/login', to: 'users#login'
    get 'users/deleteUser', to: 'users#deleteUser'
    get 'users/logout'
    post 'users/changePassword', to: 'users#changePassword'
    post 'users/changePhoto', to: 'users#changePhoto'

    post 'articles/create'
    get 'articles/board'
    post 'comments/create'
    post 'comments/delete'

    resources 'articles'
    resources 'hobbies'

    post 'idfs/createAll'
    post 'idfs/update'
    post 'idfs/destroy'


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
