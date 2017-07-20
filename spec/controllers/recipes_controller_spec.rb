# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  render_views

  describe "GET #index" do
    it "responds with HTTP 200" do
      allow(RecipePuppy).to receive(:search).and_return([])
      get :index
      expect(response).to be_ok
    end

    context "given a search query" do
      it "responds with HTTP 200 and renders results" do
        recipe = RecipePuppyRecipe.new(title: "mango stew")
        allow(RecipePuppy).to receive(:search).and_return([recipe])

        get :index, params: { query: "mango" }

        expect(response.body).to match(/mango stew/)
        expect(RecipePuppy).to have_received(:search).with(query: "mango")
      end
    end
  end
end
