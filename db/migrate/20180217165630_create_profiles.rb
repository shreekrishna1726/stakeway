class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
    	t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :user_id
      t.string :referral_id
      t.boolean :active, default: false
      t.integer :tree_level
      t.decimal :credits,  default: 0
      t.integer :ancestry_depth,  :default => 0

      t.timestamps
    end
  end
end