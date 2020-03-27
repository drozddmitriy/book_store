class ChengeColumnStatusForTableOrders < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :orders, :status, :string
  end
end
