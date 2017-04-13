Rails.application.routes.draw do

  #login
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  ###
  get 'user/update'

  get 'user/new' => 'user#new' , as: 'new_user'

  get 'user/create'

  get 'user/edit'

### Department Assistant - ROUTES
  get 'department_assistant/registration_request' => 'department_assistant#registration_request'

  get 'department_assistant/index/:id' => 'department_assistant#index', as: 'index'

  get 'department_assistant/edit' => 'department_assistant#edit'

  get 'department_assistant/update' => 'department_assistant#update'

  get 'department_assistant/show/:id' => 'department_assistant#show', as: 'show'

  get 'department_assistant/destroy' => 'department_assistant#destroy'

  get 'department_assistant/enable' => 'department_assistant#enable'
###

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
