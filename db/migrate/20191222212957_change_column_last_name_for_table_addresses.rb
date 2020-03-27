class ChangeColumnLastNameForTableAddresses < ActiveRecord::Migration[5.2]
  def up
    rename_column :addresses, :lastname, :last_name
  end

  def down
    rename_column :addresses, :last_name, :lastname
  end
end
