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

  patch 'user/update/:id', controller: 'user', action: 'update', as: 'user_update'

  get 'user/destroy/:id' => 'user#destroy', as: 'user_destroy'

  # Administrative Assistant

  # Coordinator

  # Department Assistant

  # Parsers

  get 'parsers/upload'
  post "/upload", controller: 'parsers', action: 'upload'
  post "/parsers", controller: 'parsers', action: 'index', :as => "index_parser"
  resources :parsers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
