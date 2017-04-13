Rails.application.routes.draw do


  get 'sessions/new'

### Coordinator - ROUTES
  get 'coordinator/registration_request'

  get 'coordinator/edit'

  get 'coordinator/update'

  get 'coordinator/show'

  get 'coordinator/destroy'

  get 'coordinator/enable'

  get 'user/update'

  get 'user/new'

  get 'user/create'

  get 'user/edit'

### Department Assistant - ROUTES
  get 'department_assistant/registration_request' => 'department_assistant#registration_request'

  get 'department_assistant/index/:id' => 'department_assistant#index', as: 'index'

  get 'department_assistant/edit' => 'department_assistant#edit'

  get 'department_assistant/update' => 'department_assistant#update'

  get 'department_assistant/show/:id' => 'department_assistant#show', as: 'show'

  get 'department_assistant/destroy/:id' => 'department_assistant#destroy', as: 'destroy'

  get 'department_assistant/enable' => 'department_assistant#enable'
###

### Administrative Assistant - ROUTES
  get 'administrative_assistant/show/:id' => 'administrative_assistant#show', as: 'adm_show'
  get 'administrative_assistant/remove/:id' => 'administrative_assistant#remove', as: 'adm_remove'
  get 'administrative_assistant/index_users' => 'administrative_assistant#index_users'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
