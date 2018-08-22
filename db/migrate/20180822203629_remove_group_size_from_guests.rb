class RemoveGroupSizeFromGuests < ActiveRecord::Migration[5.2]
  def change
    remove_column :guests, :group_size, :string
  end
end
