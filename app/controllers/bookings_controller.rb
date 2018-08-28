class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    binding.pry
    if @booking.save
      @rooms = Room.all
      redirect_to booking_path(@booking)
    else
      redirect_to new_booking_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :group_size)
  end

end
