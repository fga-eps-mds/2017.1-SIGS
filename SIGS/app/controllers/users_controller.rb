# frozen_string_literal: true

# class that controller the actions of a user
class UsersController < ApplicationController
  require_relative '../../lib/modules/user_module.rb'
  before_action :logged_in?, except: [:new, :create]

  def new
    @user = User.new
    @user.build_deg
    @user.build_coordinator
    @user.build_administrative_assistant
  end

  def show
    @user = User.find(params[:id])
    @school_room_count = school_rooms_by_user.count
    @school_rooms_allocated_count = school_rooms_allocated_count
    @periods = Period.all
    @solicitation_count = Solicitation.where("requester_id='#{current_user.id}'").count
    return unless @user.id != current_user.id && permission[:level] != 2
    redirect_to_current_user
  end

  def index
    @users = User.where('id != ? and active = 1', current_user.id)
    return unless permission[:level] != 2
    redirect_to_current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if params[:type] == 'deg'
        @deg = Deg.create(user: @user)
      elsif params[:type] == 'administrative_assistant'
        @administrative_assistant = AdministrativeAssistant.create(user: @user)
      end
      redirect_to sign_in_path
      flash[:notice] = 'Solicitação de cadastro efetuado com sucesso!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    return unless @user.id != current_user.id
    redirect_to_current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path
      flash[:success] = 'Dados atualizados com sucesso'
    else
      redirect_to user_edit_path
      flash[:warning] = 'Dados não foram atualizados'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id
      if permission[:level] == 2 &&
         AdministrativeAssistant.joins(:user).where(users: { active: true }).count == 1
        flash[:error] = 'Não é possível excluir o único Assistente Administrativo'
        redirect_to current_user
      else
        @user.update(active: 2)
        flash[:success] = 'Usuário excluído com sucesso'
        redirect_to sign_in_path
      end
    else
      flash[:error] = 'Acesso Negado'
      redirect_back fallback_location: { action: 'show', id: current_user.id }
    end
  end

  private

  def user_params
    if params[:type] == 'coordinator'
      params[:user].permit(:id, :name, :email, :password, :registration,
                           :cpf, :active,
                           coordinator_attributes: [:course_id, :user_id])
    else
      params[:user].permit(:id, :name, :email, :password, :registration,
                           :cpf, :active)
    end
  end

  def redirect_to_current_user
    redirect_back fallback_location: { action: 'show', id: current_user.id }
  end
end
