class RenameGuestsToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :guests, :users
  end
end
