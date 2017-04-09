Rails.application.routes.draw do
  get 'user_manager/registration_request'

  get 'user_manager/index'

  get 'user_manager/edit'

  get 'user_manager/update'

  get 'user_manager/view'

  get 'user_manager/remove'

  get 'user_manager/enable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
