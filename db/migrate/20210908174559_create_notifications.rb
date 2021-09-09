class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visited_id
      t.integer :visitor_id
      t.integer :post_id
      t.integer :comment_id
      t.string :action, default: ""
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
