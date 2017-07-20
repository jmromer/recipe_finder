# frozen_string_literal: true
require "rails_helper"

RSpec.feature "Recipe Search", type: :feature do
  scenario "User can search for recipes from home page" do
    visit root_url

    fill_in "search", with: "chicken"
    click_button "Search"

    expect(page).to have_text("soup")
  end
end
