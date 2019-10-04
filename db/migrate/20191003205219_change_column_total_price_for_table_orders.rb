class ChangeColumnTotalPriceForTableOrders < ActiveRecord::Migration[5.2]
  def up
   change_column :orders, :total_price, :decimal, precision: 5, scale: 2, null: true
 end

 def down
   change_column :orders, :total_price, :decimal, precision: 5, scale: 2, null: false
 end
end
