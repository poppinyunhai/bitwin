class ChangeTypeInOperation < ActiveRecord::Migration
  def change
  	rename_column :operations, :type, :currency_str
  end
end
