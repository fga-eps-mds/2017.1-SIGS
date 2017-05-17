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

  def categories_params
    params[:category].permit(:name)
  end

  def index
    @categories = Category.all
  end
end
