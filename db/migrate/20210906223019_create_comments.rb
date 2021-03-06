class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :content,null: false
      t.float :rate,default: 0

      t.timestamps
    end
  end
end
