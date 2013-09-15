class AddGoogleAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_auth, :bool
  end
end
