class CreateMyOrders < ActiveRecord::Migration
  def change
    create_table :my_orders do |t|
      t.datetime :data1
      t.datetime :data2
      t.datetime :data3
      t.string :name
      t.text :desc

      t.timestamps null: false
    end
  end
end
