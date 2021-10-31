class AddMessageToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :message, :text
  end
end
