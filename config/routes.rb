# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes, only: %i(index)
  root to: "static_pages#home"
end
