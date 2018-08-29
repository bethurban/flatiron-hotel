class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :checkin, :checkout, :user_id, :room_id, presence: true
  validates :group_size, presence: true, numericality: { only_integer: true }

  def date_range
    Range.new(self.checkin, self.checkout)
  end

  def self.bookings_between(start_date, end_date)
    booked = []
    range = Range.new(start_date, end_date)
    Booking.all.each do |booking|
      if booking.date_range.overlaps?(range)
        booked << booking
      end
    end
    booked
  end

  def self.available_rooms(start_date, end_date, group_size)
    available = []
    range = Range.new(start_date, end_date)
    Room.all.each do |room|
      room.bookings.each do |booking|
        if !booking.date_range.overlaps?(range) && room.capacity >= group_size && !available.include?(room)
          available << room
        end
      end
    end
    available
  end

end
