class Review < ApplicationRecord
  belongs_to :user

  validates :title,  presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }
  validates :body,   presence: true  # 総合感想は必須のまま
  
  # 詳細項目は任意入力、ただし入力時は文字数制限
  validates :lyrics_review, length: { maximum: 500 }, allow_blank: true
  validates :melody_review, length: { maximum: 500 }, allow_blank: true
  validates :vocals_review, length: { maximum: 500 }, allow_blank: true
  validates :performance_review, length: { maximum: 500 }, allow_blank: true
end
