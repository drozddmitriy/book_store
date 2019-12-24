class ChangeColumnFirstNameForTableAddresses < ActiveRecord::Migration[5.2]
  def up
    rename_column :addresses, :firstname, :first_name
  end

  def down
    rename_column :addresses, :first_name, :firstname
  end
end
