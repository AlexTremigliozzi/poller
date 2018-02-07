class AddAcceptUpdateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accept_update, :boolean
  end
end
