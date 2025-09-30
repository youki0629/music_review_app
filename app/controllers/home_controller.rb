# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # @reviews = Review.includes(:user).order(created_at: :desc)
  end
end