class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :coupon, unique: true, null: false
      t.boolean :active, default: false
      t.decimal :sale, precision: 6, scale: 2, null: false
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
