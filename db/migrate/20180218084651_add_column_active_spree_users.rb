class AddColumnActiveSpreeUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_users, :active, :boolean, default: false
  end
end
