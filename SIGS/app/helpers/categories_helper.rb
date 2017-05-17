# frozen_string_literal: true

# Categories module
module CategoriesHelper
  def all_categories
    @categories = Category.all
  end
end
