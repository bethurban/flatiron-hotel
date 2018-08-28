class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect to new_booking_path
    end
  end
end
