class AddItemImageToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :item_image, :string
  end
end
