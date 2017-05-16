# frozen_string_literal: true

# Controller Categories class
class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    @category.save
  end

  def categories_params
    params[:category].permit(:name, room_ids: [])
  end
end
