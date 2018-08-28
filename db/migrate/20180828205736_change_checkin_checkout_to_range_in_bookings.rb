class ChangeCheckinCheckoutToRangeInBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :checkin, :date
    remove_column :bookings, :checkout, :date
    add_column :bookings, :date_range, :date
  end
end
