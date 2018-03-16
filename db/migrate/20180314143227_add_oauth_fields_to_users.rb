class AddOauthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_id, :string
    add_column :users, :authentication_token, :string
  end
end
