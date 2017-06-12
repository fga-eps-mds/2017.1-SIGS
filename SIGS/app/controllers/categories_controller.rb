# frozen_string_literal: true

# Controller Categories class
class CategoriesController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_administrative_assistant?

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      flash[:success] = 'Categoria criada'
    else
      flash[:error] = 'Não foi possivel criar categoria. Categoria já registrada
                       ou campo de preechimento estava vazio.'
    end
    redirect_to categories_index_path
  end

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    return unless @category.update_attributes(categories_params)
    redirect_to categories_index_path
    flash[:success] = 'Categoria atualizada com sucesso'
  end

  def categories_params
    params[:category].permit(:name)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = 'Categoria excluída com sucesso'
    redirect_to categories_index_path
  end
end
