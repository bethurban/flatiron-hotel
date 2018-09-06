class BookingsController < ApplicationController

  def new
    @checkin = Date.new params[:booking][:checkin][:year].to_i, params[:booking][:checkin][:month].to_i, params[:booking][:checkin][:day].to_i
    @checkout = Date.new params[:booking][:checkout][:year].to_i, params[:booking][:checkout][:month].to_i, params[:booking][:checkout][:day].to_i
    @date_range = Range.new(@checkin, @checkout)
    @group_size = params[:booking][:group_size]
    @rooms = Room.all
    @user = User.find_by_id(session[:user_id])
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to new_booking_path
    end
  end

  def show
    if session[:user_id]
      @booking = Booking.find_by_id(params[:id])
      @user = User.find_by_id(@booking.user_id)
      @room = Room.find_by_id(@booking.room_id)
      @room_img = "room_#{@room.room_number}.jpg"
    else
      redirect_to root_path
    end
  end

  def index
    if session[:user_id] && params[:start_date] && params[:end_date]
      @start = Date.new params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i
      @ending = Date.new params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i
      @bookings = Booking.bookings_between(@start, @ending)
      @user = User.find_by_id(session[:user_id])
    elsif session[:user_id]
      @user = User.find_by_id(session[:user_id])
      #binding.pry
      if @user.admin?
        @bookings = Booking.all.order(:checkin)
      else
        user_bookings = @user.bookings
        @bookings = user_bookings.order(:checkin)
      end
    else
      redirect_to root_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :checkin, :checkout, :group_size)
  end

end
