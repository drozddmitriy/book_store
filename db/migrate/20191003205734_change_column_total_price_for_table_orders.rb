class ChangeColumnTotalPriceForTableOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total_price, :decimal, precision: 5, scale: 2, null: true
  end
end
