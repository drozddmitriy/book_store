class AddColumnStepToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :step, :string
  end
end
