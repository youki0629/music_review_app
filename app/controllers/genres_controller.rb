class GenresController < ApplicationController
  def index
    genres = Review.distinct.pluck(:genre)
    
    respond_to do |format|
      format.json { render json: genres }
    end
  end
end
