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

  def self.query_for_n_entries(n:, query:, ingredients: nil)
    page = 0
    empty_result_sets_encountered = 0

    entries = []
    overrall_length = 0

    loop do
      page += 1
      results = search(query: query, ingredients: ingredients, page: page)

      # end loop when empty result sets are returned repeatedly
      empty_result_sets_encountered += 1 if results.empty?
      break if empty_result_sets_encountered > 2

      entries.push(*results)
      overrall_length += results.length

      # end loop if the desired list length has been achieved
      break if overrall_length >= n
    end

    entries.first(n)
  end
end
