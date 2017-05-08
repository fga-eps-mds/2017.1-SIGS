# Module to check the permission level on pages
module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def permission
    session_user_id = session[:user_id]
    coordinator = Coordinator.find_by(user_id: session_user_id)
    department_assistant = DepartmentAssistant.find_by(user_id: session_user_id)
    administrative_assistant = AdministrativeAssistant.find_by(user_id: session_user_id)
    if coordinator
      @permission ||= {:level => 1, :type => "Coordinator"}
    elsif department_assistant
      @permission ||= {:level => 2, :type => "Department Assistant"}
    elsif administrative_assistant
      @permission ||= {:level => 3, :type => "Administrative Assistant"}
    end
  end

  def logged_in?
      if !current_user
        flash.now[:notice] =  'Você precisa estar logado'
        render 'sessions/new'
      end
  end

  def validade_permission_for_school_room
    if permission == 3
      redirect_to current_user , error: 'Você não tem permissão'
    end
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
    @permission = nil
  end

  def authenticate_administrative_assistant?
      if permission[:level] != 3
        flash[:error] =  'Acesso Negado'
        redirect_to current_user
      end
  end
end
