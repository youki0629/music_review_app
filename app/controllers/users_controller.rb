# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # 本人以外のアクセスを制限
    redirect_to root_path unless @user == current_user
    @reviews = @user.reviews.includes(:user).order(created_at: :desc)
  end
end

