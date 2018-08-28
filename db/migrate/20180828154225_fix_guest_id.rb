class FixGuestId < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :guest_id, :user_id
  end
end
