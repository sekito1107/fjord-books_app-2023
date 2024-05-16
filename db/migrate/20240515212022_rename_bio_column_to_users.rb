class RenameOldColumnNameToNewColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :bio, :self_introduction
  end
end
