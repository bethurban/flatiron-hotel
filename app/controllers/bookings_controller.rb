class BookingsController < ApplicationController

  def new
    binding.pry
    @checkin = params[:booking][:checkin].to_s.to_date
    @checkout = params[:booking][:checkout].to_s.to_date
    @date_range = Range.new(@checkin, @checkout)
    @group_size = params[:booking][:group_size]

    @rooms = Room.all
  end

  def create
    @booking = Booking.new(booking_params)
    array = booking_params[:date_range].split("..")

    date1 = array[0].to_date
    date2 = array[1].to_date
    @booking.date_range = Range.new(date1, date2)
    #can't save date_range as a Range object - may have to instead capture the full range
    #as a string here, then convert that to a Range object in the show page
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
