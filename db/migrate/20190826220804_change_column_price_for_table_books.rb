class ChangeColumnPriceForTableBooks < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :price, :decimal, precision: 5, scale: 2, null: false
  end
end
