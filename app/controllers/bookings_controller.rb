class BookingsController < ApplicationController

  def new
    @checkin = Date.new params[:booking][:checkin][:year].to_i, params[:booking][:checkin][:month].to_i, params[:booking][:checkin][:day].to_i
    @checkout = Date.new params[:booking][:checkout][:year].to_i, params[:booking][:checkout][:month].to_i, params[:booking][:checkout][:day].to_i
    current_user
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
    current_user
    if @booking.save
      render json: @booking, status: 201
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
      respond_to do |f|
        f.html {render :show}
        f.json {render json: @booking}
      end
    else
      redirect_to root_path
    end
  end

  def index
    if session[:user_id] && params[:start_date] && params[:end_date]
      @start = Date.new params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i
      @ending = Date.new params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i
      current_user
      if @start >= Date.today && @start < @ending
        @bookings = Booking.bookings_between(@start, @ending)
      else
        flash[:notice] = "Check-in and check-out dates must be in the future."
        redirect_to user_path(@user)
      end
    elsif session[:user_id]
      current_user
      if @user.admin?
        @bookings = Booking.all.order(:checkin)
      else
        @bookings = @user.bookings
        # @bookings = user_bookings.order(:checkin)
        respond_to do |f|
          f.html {render :index}
          f.json {render json: @bookings}
        end
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
