class AddSelectionIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :selection_id, :integer
  end
end
