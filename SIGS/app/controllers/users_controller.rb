class UsersController < ApplicationController
  before_action :logged_in?, except: [:new,:create]

  def new
		@user = User.new
    @user.build_department_assistant
    @user.build_coordinator
    @user.build_administrative_assistant
	end

  def show
    @user = User.find(params[:id])
    if (@user.id != current_user.id && permission[:level] != 3)
      redirect_back fallback_location: {action: "show", id:current_user.id}
    end
  end

  def index
    @users = User.where('id != ? and active != false', current_user.id)
    if (permission[:level]!= 3)
      redirect_back fallback_location: {action: "show", id:current_user.id}
    end
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      if params[:type] == "administrative_assistant"
        @administrative_assistant = AdministrativeAssistant.create(user_id: @user.id)
      end
      redirect_to sign_in_path
      flash[:notice] = 'Solicitação de cadastro efetuado com sucesso!'
    else
      render :new
    end
  end

    def edit
    @user = User.find(params[:id])
    if (@user.id != current_user.id)
      redirect_back fallback_location: {action: "show", id:current_user.id}
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path
      flash[:success] = ("Dados atualizados com sucesso")
    else
      redirect_to user_edit_path
      flash[:warning] = t(:error_profile_update)
    end
  end

  def destroy
    @user = User.find(params[:id])
    if (@user.id == current_user.id)
      if permission[:level] == 3 and AdministrativeAssistant.all.count == 1
          flash[:error] = "Não é possível excluir o único Assistente Administrativo"
          redirect_to current_user
      else
        @user.destroy
        flash[:success] = "Usuário excluído com sucesso"
        redirect_to sign_in_path
      end
    else
      flash[:error] = "Acesso Negado"
      redirect_back fallback_location: {action: "show", id:current_user.id}
    end
  end

  private
  def user_params
    if params[:type] == "coordinator"
      params[:user].permit(:id,:name, :email, :password,:registration, :cpf, :active,
                            :coordinator_attributes =>[:course_id,:user_id])
    elsif params[:type] == "department_assistant"
      params[:user].permit(:id,:name, :email, :password,:registration, :cpf, :active,
                          :department_assistant_attributes => [:department_id,:user_id])
    else
      params[:user].permit(:id,:name, :email, :password,:registration, :cpf, :active,
                          :administrative_assistant_attributes => [:user_id])
    end
  end
end
