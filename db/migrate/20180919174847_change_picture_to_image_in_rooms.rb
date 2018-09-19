class ChangePictureToImageInRooms < ActiveRecord::Migration[5.2]
  def change
    rename_column :rooms, :picture, :image
  end
end
