class AddGoogleSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_secret, :string
  end
end
