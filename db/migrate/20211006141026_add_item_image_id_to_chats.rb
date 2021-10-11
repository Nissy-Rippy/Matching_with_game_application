class AddItemImageIdToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :item_image_id, :string
  end
end
