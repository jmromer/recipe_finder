# frozen_string_literal: true
require "rails_helper"

RSpec.describe RecipePuppyRecipe, type: :model do
  describe ".new_collection" do
    it "turns a list of attribute hashes into one of instances" do
      attrs = [{ "title" => "Recipe 1",
                 "href" => "https://example.com",
                 "thumbnail" => "https://example.com/image.jpg",
                 "ingredients" => "1,2,3,4" }]

      result = described_class.new_collection(attrs)

      expect(result).to be_an_instance_of(Array)
      expect(result).to all(be_an_instance_of(described_class))
    end
  end

  describe ".new" do
    it "makes attributes accessible via methods" do
      attrs = { title: "Recipe 1",
                href: "https://example.com",
                thumbnail: "https://example.com/image.jpg",
                ingredients: "1,2,3,4" }

      recipe = described_class.new(attrs)

      expect(recipe.title).to eq attrs[:title]
      expect(recipe.url).to eq attrs[:href]
      expect(recipe.thumbnail_url).to eq attrs[:thumbnail]
      expect(recipe.ingredients_list).to eq attrs[:ingredients].split(",")
    end
  end
end
