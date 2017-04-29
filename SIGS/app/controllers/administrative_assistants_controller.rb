class AdministrativeAssistantsController < ApplicationController


  def registration_request
    @users = User.where(active: false)
    return @users
  end

  def enable_registration
    @user = User.find(params[:id])
    if @user.update_attributes(active: true)
      flash[:success] = "Usuário aprovado com sucesso"
    end
    redirect_to registration_request_path
  end

  def decline_registration
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Usuário recusado com sucesso"
    else
      flash[:error] = "Não foi possivel recusar o usuário"
    end
    redirect_to registration_request_path
  end

  def destroy_users
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to user_index_path, :flash => {:sucess => 'Usuário excluído com sucesso'}
    end
  end

  private
  def users_update_params
    params.require(:user).permit(:name, :email, :cpf, :registration)
  end

  def administrative_assistant_params
    params[:administrative_assistant].permit(:user_id)
  end
end
