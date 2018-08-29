class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings

  def self.available_rooms(start_date, end_date, group_size)
    available = []
    range = Range.new(start_date, end_date)
    self.all.each do |room|
      room.bookings.each do |booking|
        if !booking.date_range.overlaps?(range) && room.capacity >= group_size && !available.include?(room)
          available << room
        end
      end
    end
    available
  end
  
end
