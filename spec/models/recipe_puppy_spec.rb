# frozen_string_literal: true
require "rails_helper"

RSpec.describe RecipePuppy, type: :model do
  describe ".search" do
    it "queries the recipe puppy api for recipes and parses the response" do
      VCR.use_cassette("recipe puppy search query with results") do
        recipes = described_class.search(query: "chicken")

        expect(recipes).to be_an_instance_of Array
        expect(recipes).to all(be_an_instance_of(RecipePuppyRecipe))
        expect(recipes.count).to eq 10
      end
    end

    context "given no results" do
      it "returns an empty array" do
        VCR.use_cassette("recipe puppy search query with no results") do
          recipes = described_class.search(query: "8938u98")

          expect(recipes).to be_an_instance_of Array
          expect(recipes).to be_empty
        end
      end
    end

    context "given a missing page of results returning a 404 HTML template" do
      it "returns an empty array" do
        VCR.use_cassette("recipe puppy search query with missing results") do
          recipes = described_class.search(query: "vodka", page: 2)

          expect(recipes).to be_an_instance_of Array
          expect(recipes).to be_empty
        end
      end
    end
  end

  describe ".search_for_n_entries" do
    it "queries the recipe puppy api for recipes and parses the response" do
      VCR.use_cassette("recipe puppy search query paginated request") do
        recipes = described_class.query_for_n_entries(n: 15, query: "chicken")

        expect(recipes).to be_an_instance_of Array
        expect(recipes).to all(be_an_instance_of(RecipePuppyRecipe))
        expect(recipes.count).to eq 15
      end
    end
  end
end
