class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[show edit update destroy]
  before_action :set_genres, only: %i[new create edit update]

  # 定数として定義
  GENRES = [
    "ROCK",
    "JAZZ", 
    "POP",
    "CLASSICAL",
    "ELECTRONIC",
    "FOLK",
    "BLUES"
  ].sort.freeze

  def index
    @reviews = current_user.reviews
    
    # キーワード検索の追加
    if params[:keyword].present?
      @reviews = @reviews.where(
        "title ILIKE ? OR artist ILIKE ?", 
        "%#{params[:keyword]}%", "%#{params[:keyword]}%"
      )
    end
    
    # ジャンル検索の追加
    if params[:genre].present?
      @reviews = @reviews.where(genre: params[:genre])
    end
    
    # ソート機能の追加
    case params[:sort]
    when 'created_at_asc'
      @reviews = @reviews.order(created_at: :asc)
    when 'title_asc'
      @reviews = @reviews.order(title: :asc)
    when 'artist_asc'
      @reviews = @reviews.order(artist: :asc)
    else
      @reviews = @reviews.order(created_at: :desc)
    end
    
    @reviews = @reviews.page(params[:page]).per(20)
    
    # 検索フォーム用のジャンル一覧（既存の定数を使用）
    @search_genres = GENRES
  end
  
  def new
    @review = current_user.reviews.new
    # @genres は before_action で設定済み
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to root_path, notice: "レビューを投稿しました。"
    else
      # @genres は before_action で設定済み
      flash.now[:alert] = "入力に誤りがあります。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @genres は before_action で設定済み
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: "レビューを更新しました。"
    else
      # @genres は before_action で設定済み
      flash.now[:alert] = "入力に誤りがあります。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy!
    redirect_to reviews_path, notice: "レビューを削除しました。"
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to reviews_path, alert: "レビューが見つかりませんでした。"
  end

  def set_genres
    @genres = GENRES
  end

  def review_params
    params.require(:review).permit(
      :title, :artist, :genre, :body,
      :lyrics_review, :melody_review, :vocals_review, :performance_review
    )
  end
end
