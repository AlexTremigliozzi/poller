class CreatePostCreators < ActiveRecord::Migration
  def change
    create_table :post_creators do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
