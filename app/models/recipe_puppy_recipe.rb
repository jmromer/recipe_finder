# frozen_string_literal: true

class RecipePuppyRecipe
  DEFAULT_THUMBNAIL_URL = "http://img.recipepuppy.com/9.jpg"

  attr_accessor :ingredients_list, :url, :title, :thumbnail_url

  def self.new_collection(attrs_list)
    attrs_list.map { |attrs| new(attrs.with_indifferent_access) }
  end

  def initialize(attrs)
    self.ingredients_list = (attrs[:ingredients] || "").split(/,\s?/).uniq
    self.url = attrs[:href]
    self.thumbnail_url = attrs[:thumbnail].presence || DEFAULT_THUMBNAIL_URL
    self.title = attrs[:title]
  end
end
