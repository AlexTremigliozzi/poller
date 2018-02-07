class ChangeAcceptUpdateToUsers < ActiveRecord::Migration
    def up
      change_column :users, :accept_update, :boolean, default: true
    end

    def down
      change_column :users, :accept_update, :boolean, default: nil
    end
end
