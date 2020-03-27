class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 0
      t.text :comment
      t.string :title
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean :publish, default: false

      t.timestamps
    end
  end
end
