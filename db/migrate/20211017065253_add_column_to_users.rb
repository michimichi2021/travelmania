class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :introduction, :text
    add_column :users, :is_deleted, :boolean, null: false, default: false
  end
end
