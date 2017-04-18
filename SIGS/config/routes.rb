Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Parsers
  post "/upload_buildings", controller: 'parsers', action: 'upload_buildings'
  post "/upload", controller: 'parsers', action: 'upload_rooms'
  post "/parsers", controller: 'parsers', action: 'index', :as => "index_parser"
  post "/upload_departament", controller: 'parsers', action: 'upload_departaments'
  post "/upload_courses", controller: 'parsers', action: 'upload_courses'
  post "/upload_disciplines", controller: 'parsers', action: 'upload_disciplines'
  resources :parsers

end
