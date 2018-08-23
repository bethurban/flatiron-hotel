class AddAdminToGuests < ActiveRecord::Migration[5.2]
  def change
    change_table :guests do |t|
      t.boolean :admin
    end
  end
end
