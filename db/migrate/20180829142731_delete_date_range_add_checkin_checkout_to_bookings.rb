class DeleteDateRangeAddCheckinCheckoutToBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :date_range, :text
    add_column :bookings, :checkin, :date
    add_column :bookings, :checkout, :date
  end
end
