# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user

  validates :title,  presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }
  validates :body,   presence: true
  # genre はオートコンプリート導入予定なら任意でもOK
end
