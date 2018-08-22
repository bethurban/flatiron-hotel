class AddGroupSizeToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :group_size, :integer
  end
end
