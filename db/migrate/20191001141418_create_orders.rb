class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :total_price, precision:6, scale:2, null:false
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
