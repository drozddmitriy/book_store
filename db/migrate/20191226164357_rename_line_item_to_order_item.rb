class RenameLineItemToOrderItem < ActiveRecord::Migration[5.2]
  def change
    rename_table :line_items, :order_items
  end
end
