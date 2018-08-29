class ChangeDateRangeToTextInBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :date_range, :text
  end
end
