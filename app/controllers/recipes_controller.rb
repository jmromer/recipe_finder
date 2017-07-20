# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    recipes = RecipePuppy.search(query: params[:query])
    render :index, locals: { recipes: recipes }, layout: false
  end
end
