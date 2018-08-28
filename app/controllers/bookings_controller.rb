class BookingsController < ApplicationController

  def new
    binding.pry
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to new_booking_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :checkin, :checkout, :group_size)
  end

end
