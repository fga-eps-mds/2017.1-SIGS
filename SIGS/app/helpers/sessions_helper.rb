module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    coordinator = Coordinator.find_by(user_id: session[:user_id])
    department_assistant = DepartmentAssistant.find_by(user_id: session[:user_id])
    administrative_assistant = AdministrativeAssistant.find_by(user_id: session[:user_id])
    if coordinator
      @nvl = 1
    end
    if department_assistant
      @nvl = 2
    end
    if administrative_assistant
      @nvl = 3
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def block_access
    if current_user.present?
      flash.now[:error] =  'Você já está logado'
      redirect_to current_user
    end
  end

  def permission
    permission ||= @nvl
  end

  def logged_in?
      if current_user.nil?
        flash.now[:notice] =  'Você precisa estar logado'
        redirect_to sign_in_path
      end
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
