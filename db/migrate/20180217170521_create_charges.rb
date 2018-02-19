class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
    	t.integer :profile_id
    	t.decimal :amount, default: 0
    	t.string :txn_number
      t.timestamps
    end
  end
end
