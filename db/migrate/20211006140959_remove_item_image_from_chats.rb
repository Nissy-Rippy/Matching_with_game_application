class RemoveItemImageFromChats < ActiveRecord::Migration[5.2]
  def change
    remove_column :chats, :item_image, :string
  end
end
