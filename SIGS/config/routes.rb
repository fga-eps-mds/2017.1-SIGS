Rails.application.routes.draw do

### Department Assistant - ROUTES
  get 'department_assistant/registration_request'

  get 'department_assistant/index'

  get 'department_assistant/edit'

  get 'department_assistant/update'

  get 'department_assistant/show'

  get 'department_assistant/destroy'

  get 'department_assistant/enable'
###

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
