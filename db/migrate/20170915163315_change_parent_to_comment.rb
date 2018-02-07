class ChangeParentToComment < ActiveRecord::Migration
    def change
      change_column :comments, :parent_id, :integer, :null => true, :index => true
      change_column :comments, :rgt, :integer, :null => false, :index => true
      change_column :comments, :lft, :integer, :null => false, :index => true
    end
end



