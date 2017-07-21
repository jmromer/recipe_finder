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
        results = (1..10).map do
          RecipePuppyRecipe
            .new(title: "mango stew", thumbnail: "example.com/image.jpg")
        end
        allow(RecipePuppy).to receive(:search).and_return(results)

        get :index, params: { query: "mango" }

        expect(response.body).to match(/mango stew/)
        expect(RecipePuppy).to have_received(:search).twice
      end
    end
  end
end
