module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    coordinator = Coordinator.find_by(user_id: session[:user_id])
    department_assistant = DepartmentAssistant.find_by(user_id: session[:user_id])
    administrative_assistant = AdministrativeAssistant.find_by(user_id: session[:user_id])
    if coordinator
      @level = 1
    elsif department_assistant
      @level = 2
    elsif administrative_assistant
      @level = 3
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def block_access
    if current_user.present?
      redirect_to current_user
    end
  end

  def permission
    @permission ||= @nvl
  end

  def logged_in?
      if current_user.nil?
        redirect_to sign_in_path
      end
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
