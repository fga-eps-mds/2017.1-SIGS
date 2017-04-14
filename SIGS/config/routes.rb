Rails.application.routes.draw do
  get 'parsers/upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/upload", controller: 'parsers', action: 'upload'
  post "/parsers", controller: 'parsers', action: 'index', :as => "index_parser"
  resources :parsers

end
