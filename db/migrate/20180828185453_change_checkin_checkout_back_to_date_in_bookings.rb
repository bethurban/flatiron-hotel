class ChangeCheckinCheckoutBackToDateInBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :checkin, :date
    change_column :bookings, :checkout, :date
  end
end
