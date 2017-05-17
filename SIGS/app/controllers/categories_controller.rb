# frozen_string_literal: true

# Controller Categories class
class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    @category.save
    redirect_to categories_index_path
    flash[:success] = 'Categoria criada'
  end

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    return unless @category.update_attributes(category_params)
    redirect_to categories_index_path
    flash[:success] = 'Categoria atualizada com sucesso'
  end

  def categories_params
    params[:category].permit(:name)
  end
end
