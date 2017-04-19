Rails.application.routes.draw do

  root 'sessions#new'

  # Sessions

  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  # User
  get 'user/index' => 'user#index', :as => 'user_index'

  get 'user/new' => 'user#new' , :as => 'user_new'

  post 'user/new' => 'user#create' , :as =>'user_create'

  get '/user/:id' => 'user#show', :as => 'user'

  get 'user/edit/:id' => 'user#edit', as: 'user_edit'

  patch 'user/update/', controller: 'user', action: 'update', as: 'user_update'

  get 'user/destroy/:id', controller: 'user', action: 'destroy', as: 'user_destroy'

  # Coordinator

  # Department Assistant

  # Administrative Assistant

  get 'administrative_assistant/registration_request' => 'administrative_assistant#registration_request', as: 'registration_request'

  get 'administrative_assistant/enable_registration/:id' => 'administrative_assistant#enable_registration', as: 'enable_registration'

  get 'administrative_assistant/decline_registration/:id' => 'administrative_assistant#decline_registration', as: 'decline_registration'
###

# Parsers
  post "/upload_buildings", controller: 'parsers', action: 'upload_buildings'
  post "/upload", controller: 'parsers', action: 'upload_rooms'
  post "/parsers", controller: 'parsers', action: 'index', :as => "index_parser"
  post "/upload_departament", controller: 'parsers', action: 'upload_departaments'
  post "/upload_courses", controller: 'parsers', action: 'upload_courses'
  post "/upload_disciplines", controller: 'parsers', action: 'upload_disciplines'
  resources :parsers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
