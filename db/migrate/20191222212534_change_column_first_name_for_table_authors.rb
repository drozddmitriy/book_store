class ChangeColumnFirstNameForTableAuthors < ActiveRecord::Migration[5.2]
  def up
    rename_column :authors, :firstname, :first_name
  end

  def down
    rename_column :authors, :first_name, :firstname
  end
end
