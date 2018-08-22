class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :room_id
      t.integer :guest_id
      t.date :checkin
      t.date :checkout

      t.timestamps
    end
  end
end
