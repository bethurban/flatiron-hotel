class ChangeCheckinCheckoutToStringInBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :checkin, :string
    change_column :bookings, :checkout, :string
  end
end
