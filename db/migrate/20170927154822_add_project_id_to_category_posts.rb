class AddProjectIdToCategoryPosts < ActiveRecord::Migration
  def change
    add_column :category_posts, :project_id, :integer
  end
end
