class RenameItemIdColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :item_id, :post_id
  end
end
