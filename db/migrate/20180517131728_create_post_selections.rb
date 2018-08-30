class CreatePostSelections < ActiveRecord::Migration
  def change
    create_table :post_selections do |t|
      t.integer :post_id
      t.integer :selection_id

      t.timestamps null: false
    end
  end
end
