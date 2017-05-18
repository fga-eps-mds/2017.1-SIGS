Rails.application.routes.draw do

  root 'sessions#new'

  # Sessions
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  # User
  get 'users/index' => 'users#index', :as => 'user_index'
  get 'users/new' => 'users#new' , :as => 'user_new'
  post 'users/new' => 'users#create' , :as =>'user_create'
  get '/users/:id' => 'users#show', :as => 'user'
  get 'users/edit/:id' => 'users#edit', as: 'user_edit'
  patch 'users/update/:id', controller: 'users', action: 'update', as: 'user_update'
  get 'users/destroy/:id', controller: 'users', action: 'destroy', as: 'user_destroy'

  # Coordinator

  # Department Assistant

  # Administrative Assistant
  get 'administrative_assistants/registration_request' => 'administrative_assistants#registration_request', as: 'registration_request'
  get 'administrative_assistants/enable_registration/:id' => 'administrative_assistants#enable_registration', as: 'enable_registration'
  get 'administrative_assistants/decline_registration/:id' => 'administrative_assistants#decline_registration', as: 'decline_registration'
  get 'administrative_assistants/destroy_users/:id' => 'administrative_assistants#destroy_users', as: 'destroy_users'

  # Room
  get 'rooms/index' => 'rooms#index', as: 'room_index'
  get 'rooms/edit/:id' => 'rooms#edit', as: 'room_edit'
  patch 'rooms/update/:id' => 'rooms#update'
  get 'rooms/show/:id' => 'rooms#show', as: 'room'
  get 'room/destroy/:id', controller: 'rooms', action: 'destroy', as: 'room_destroy'


  # Course
  get 'courses/courses_by_user' => 'courses#courses_by_user', :as => 'courses_by_user'

  #SchoolRooms

  get 'school_rooms/new' => 'school_rooms#new', :as => 'school_rooms_new'
  post 'school_rooms/create' => 'school_rooms#create', :as => 'school_rooms_create'

  # Parsers
  post "/upload_buildings", controller: 'parsers', action: 'upload_buildings'
  post "/upload", controller: 'parsers', action: 'upload_rooms'
  get "/parsers", controller: 'parsers', action: 'index', :as => "index_parser"
  post "/upload_department", controller: 'parsers', action: 'upload_departments'
  post "/upload_courses", controller: 'parsers', action: 'upload_courses'
  post "/upload_disciplines", controller: 'parsers', action: 'upload_disciplines'
  #resources :parsers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
