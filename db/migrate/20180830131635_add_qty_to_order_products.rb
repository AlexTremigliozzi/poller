class AddQtyToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :qty, :integer
  end
end
