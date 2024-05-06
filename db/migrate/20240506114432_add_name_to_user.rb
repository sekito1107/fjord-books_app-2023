class AddNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false, default: '', limit: 100
  end
end
