class AddAncestryToProfile < ActiveRecord::Migration[5.1]
  def change
 		add_column :profiles, :ancestry, :string
    add_index :profiles, :ancestry   
  end
end
