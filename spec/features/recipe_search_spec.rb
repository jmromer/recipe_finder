# frozen_string_literal: true
require "rails_helper"

RSpec.feature "Recipe Search", type: :feature do
  scenario "User can search for recipes from home page" do
    VCR.use_cassette("recipe puppy api search query: chicken") do
      visit root_url

      fill_in "query", with: "chicken"
      click_button "Search"

      expect(page).to have_text("soup")
    end
  end
end
