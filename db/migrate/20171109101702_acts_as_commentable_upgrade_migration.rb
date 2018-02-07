class ActsAsCommentableUpgradeMigration < ActiveRecord::Migration
  def self.up
    add_column :comments, :name, :string
    add_column :comments, :number, :integer
    # rename_column :comments, :comment, :body
    # add_column :comments, :subject, :string
    # add_column :comments, :parent_id, :integer
    # add_column :comments, :lft, :integer
    # add_column :comments, :rgt, :integer
    # add_column :comments, :updated_at, :datetime
    # add_index :comments, :commentable_id
  end

  def self.down
    remove_column :comments, :name, :string
    remove_column :comments, :number
    # rename_column :comments, :body, :comment
    # remove_column :comments, :subject
    # remove_column :comments, :parent_id
    # remove_column :comments, :lft
    # remove_column :comments, :rgt
    # remove_column :comments, :updated_at
    # remove_index :comments, :commentable_id
  end
end
