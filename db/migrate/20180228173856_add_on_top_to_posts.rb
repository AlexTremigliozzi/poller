class AddOnTopToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :on_top, :boolean, :default => false
  end
end
