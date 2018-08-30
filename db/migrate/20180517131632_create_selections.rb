class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :name
      t.text :description
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
