Rails.application.routes.draw do

#  resources :university_events, except: [:new, :edit]
#  resources :student_types, except: [:new, :edit]
#  resources :faculties, except: [:new, :edit]
#  resources :job_info_sessions, except: [:new, :edit]
#  resources :addresses, except: [:new, :edit]
#  resources :event_categories, except: [:new, :edit]
#  get 'events', to: 'events#index'

#  post 'events', to: 'events#create'
#  get 'events/:id', to: 'events#show'
#  patch 'events/:id', to: 'events#update'

#  get '/event_category/:id', to: 'events#show_event_by_category'
#
#  get '/event_category/:category_id/university/:university_id', to: 'events#get_events_by_category_and_university'
#
#  get '/events/', to: 'events#get_events_by_time'
#
#  get '/job_info_sessions', to: 'job_info_sessions#index'
#  get '/job_info_sessions/:id', to: 'job_info_sessions#show'
#  get 'job_info_sessions_count', to: 'job_info_sessions#job_info_sessions_count_by_time'
#
#  get 'event_categories', to: 'event_categories#index'
#  get 'universities', to: 'universities#index'
#
#  get 'student_types', to: 'student_types#index'
#  get 'faculties', to: 'faculties#index'


  scope '/api/v2' do
    get 'event_categories', to: 'event_category#index'
    get 'sites', to: 'site#index'
    
    get 'university_events/:site_id/:category_id/:time', to: 'university_events#index'
    get 'university_event/:id', to: 'university_events#show'


  end


  #  resources :events, except: [:new, :edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

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
