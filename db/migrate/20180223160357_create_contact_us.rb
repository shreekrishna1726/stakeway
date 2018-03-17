class CreateContactUs < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_us do |t|
      t.string :title
      t.text :message
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
