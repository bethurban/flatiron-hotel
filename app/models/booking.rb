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
    bookings = Booking.order(:checkin)
    bookings.each do |booking|
      if booking.date_range.overlaps?(range)
        booked << booking
      end
    end
    booked
  end

end
