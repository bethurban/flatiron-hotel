class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  mount_uploader :image, ImageUploader

  def self.available_rooms(start_date, end_date, group_size)
    available = []
    range = Range.new(start_date, end_date)
    self.all.each do |room|
      if room.bookings != [] && room.capacity >= group_size
        if room.bookings.all? { |booking| !booking.date_range.overlaps?(range) }
          available << room
        end
      elsif room.capacity >= group_size
        available << room
      end
    end
    if available != []
      available
    else
      "There are no rooms available. Please return to the home screen to enter new dates or a different group size."
    end
  end

end
