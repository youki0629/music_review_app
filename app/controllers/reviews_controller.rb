class ReviewsController < ApplicationController
  before_action :authenticate_user!  # 未ログインなら投稿不可

  def index
    @reviews = current_user.reviews.order(created_at: :desc)
  end

  def show
    @review = current_user.reviews.find(params[:id])
  end

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to root_path, notice: "レビューを投稿しました。"
    else
      flash.now[:alert] = "入力に誤りがあります。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :artist, :genre, :body)
  end
end