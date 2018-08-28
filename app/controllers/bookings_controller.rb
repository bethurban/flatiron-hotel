class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    checkin = params[:booking][:checkin]
    checkout = params[:booking][:checkout]
    checkin_date = Date.new checkin["year"].to_i, checkin["month"].to_i, checkin["day"].to_i
    @booking.checkin = checkin_date
    checkout_date = Date.new checkout["year"].to_i, checkout["month"].to_i, checkout["day"].to_i
    @booking.checkout = checkout_date
    @booking.group_size = params[:booking][:group_size]

    @rooms = Room.all
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
