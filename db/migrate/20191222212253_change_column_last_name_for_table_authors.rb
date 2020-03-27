class ChangeColumnLastNameForTableAuthors < ActiveRecord::Migration[5.2]
  def up
    rename_column :authors, :lastname, :last_name
  end

  def down
    rename_column :authors, :last_name, :lastname
  end
end
