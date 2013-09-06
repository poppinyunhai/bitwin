class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
      t.string :area
      t.string :ip_address
      t.string :action_type
      t.references :user, index: true

      t.timestamps
    end
  end
end
