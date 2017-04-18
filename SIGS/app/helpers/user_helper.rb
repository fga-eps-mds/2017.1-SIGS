module UserHelper
  def type(current_user)
    coordinator = Coordinator.find_by(user_id:current_user)
    department_assistant = DepartmentAssistant.find_by(user_id: current_user)
    administrative_assistant = AdministrativeAssistant.find_by(user_id: current_user)
    if coordinator
      { :level => 1 ,:type => "Coordenador"}
    elsif department_assistant
      { :level => 2, :type => "Assistente de departameto"}
    elsif administrative_assistant
      {:level => 3, :type =>"Assistende Administrativo"}
    end

  end
end
