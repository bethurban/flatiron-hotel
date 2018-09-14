class BookingsController < ApplicationController

  def new
    @checkin = Date.new params[:booking][:checkin][:year].to_i, params[:booking][:checkin][:month].to_i, params[:booking][:checkin][:day].to_i
    @checkout = Date.new params[:booking][:checkout][:year].to_i, params[:booking][:checkout][:month].to_i, params[:booking][:checkout][:day].to_i
    @user = User.find_by_id(session[:user_id])
    @group_size = params[:booking][:group_size].to_i
    if @checkin >= Date.today && @checkin < @checkout && @group_size > 0
    elsif @group_size > 0
      flash[:notice] = "Check-in and check-out dates must be in the future."
      redirect_to user_path(@user)
    elsif @checkin >= Date.today && @checkin < @checkout && @group_size == 0
      flash[:notice] = "Please enter the number of guests (1, 2, etc.)."
      redirect_to user_path(@user)
    else
      flash[:notice] = "Check-in and check-out dates must be in the future, and a number of guests must be entered (1, 2, etc.)."
      redirect_to user_path(@user)
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @user = User.find_by_id(session[:user_id])
    if @booking.save
      flash[:notice] = "Your booking has been confirmed!"
      redirect_to user_booking_path(@user, @booking)
    else
      redirect_to user_available_path(@user)
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
      @user = User.find_by_id(session[:user_id])
      if @start >= Date.today && @start < @ending
        @bookings = Booking.bookings_between(@start, @ending)
      else
        flash[:notice] = "Check-in and check-out dates must be in the future."
        redirect_to user_path(@user)
      end
    elsif session[:user_id]
      @user = User.find_by_id(session[:user_id])
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
