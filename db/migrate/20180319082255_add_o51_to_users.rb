class AddO51ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :o51_authentication_token, :string         # Will store the auth token
    add_column :users, :o51_authentication_token_secret, :string  # Will store the token secret used for refresh
    add_column :users, :o51_expires_at, :datetime                 # Will hold token expiration
    add_column :users, :o51_profile, :text                        # or :json if you're on postgres
    add_column :users, :o51_picture_url, :string                  # link to the picture
    add_column :users, :o51_uid, :string                          # Uid of the user
    add_column :users, :o51_points, :integer                      # Points of the user
  end
end
