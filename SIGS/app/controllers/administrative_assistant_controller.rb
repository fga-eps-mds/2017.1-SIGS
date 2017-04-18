class AdministrativeAssistantController < ApplicationController

  # Funções de edição do próprio usuário

  def enable
    @user = User.find(:id)
    @user.active = true
  end

  def approve_registration
    @user = User.find_by(active: false)
  end
  
end
