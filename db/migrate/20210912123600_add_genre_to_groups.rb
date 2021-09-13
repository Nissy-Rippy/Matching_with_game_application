class AddGenreToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :genre, :string
  end
end
