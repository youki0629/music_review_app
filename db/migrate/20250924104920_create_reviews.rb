class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :artist
      t.string :genre
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
