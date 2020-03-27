class DropTableAuthorsBooks < ActiveRecord::Migration[5.2]
  def change
    drop_table :authors_books
  end
end
