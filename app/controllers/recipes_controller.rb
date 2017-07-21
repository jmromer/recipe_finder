# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    recipes = RecipePuppy.query_for_n_entries(n: 20, query: params[:query])
    render :index, locals: { recipes: recipes }, layout: false
  end
end
