# frozen_string_literal: true

class RecipePuppy
  include HTTParty
  base_uri "http://www.recipepuppy.com/api"

  def self.search(query:, ingredients: nil, page: nil)
    options = {}.tap do |opt|
      opt[:i] = ingredients if ingredients.present?
      opt[:q] = query if query.present?
      opt[:p] = page if page.present?
    end

    response_body = get("/", query: options).body

    results = begin
                JSON.parse(response_body).fetch("results")
              rescue JSON::ParserError, KeyError => e
                Rails.logger.info("RecipePuppy API Error: #{e}")
                []
              end

    RecipePuppyRecipe.new_collection(results)
  end
end
