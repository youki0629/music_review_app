class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = current_user.reviews
                           .order(created_at: :desc)
                           .page(params[:page])
                           .per(20)
  end

  def show
  # @reviewはbefore_actionで設定済み
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

  def edit
  # @reviewはbefore_actionで設定済み
  end
  
  def update
    # @reviewはbefore_actionで設定済み
    if @review.update(review_params)
      redirect_to @review, notice: 'レビューを更新しました'
    else
      render :edit  # ← editテンプレートを再表示（エラー情報付き）
    end
  end

  def destroy
    # @reviewはbefore_actionで設定済み
    @review.destroy!
    redirect_to reviews_path, notice: 'レビューを削除しました'
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :artist, :genre, :body)
  end
end
