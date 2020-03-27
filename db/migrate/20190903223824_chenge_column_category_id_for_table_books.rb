class ChengeColumnCategoryIdForTableBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :category_id
    add_reference :books, :category, index: true
  end
end
