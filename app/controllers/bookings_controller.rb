class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    checkin = params[:booking][:checkin]
    checkout = params[:booking][:checkout]
    checkin_date = Date.new checkin["year"].to_i, checkin["month"].to_i, checkin["day"].to_i
    checkout_date = Date.new checkout["year"].to_i, checkout["month"].to_i, checkout["day"].to_i
    @booking.date_range = Range.new(checkin_date, checkout_date)
    @booking.group_size = params[:booking][:group_size]

    @rooms = Room.all
  end

  def create
    @booking = Booking.new(booking_params)
    array = booking_params[:date_range].split("..")
    date_array1 = array.first.split("-")
    date1 = Date.new date_array1[0].to_i, date_array1[1].to_i, date_array1[2].to_i
    date_array2 = array.last.split("-")
    date2 = Date.new date_array2[0].to_i, date_array2[1].to_i, date_array2[2].to_i
    @booking.date_range = Range.new(date1, date2)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to new_booking_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :date_range, :group_size)
  end

end
