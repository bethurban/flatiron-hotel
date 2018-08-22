class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.integer :cost
      t.integer :capacity

      t.timestamps
    end
  end
end
