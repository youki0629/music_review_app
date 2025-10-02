class AddDetailedReviewsToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :lyrics_review, :text
    add_column :reviews, :melody_review, :text
    add_column :reviews, :vocals_review, :text
    add_column :reviews, :performance_review, :text
  end
end
