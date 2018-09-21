class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.valid?
      @room.save
      redirect_to room_path(@room)
    else
      render new_room_path
    end
  end

  def index
    if session[:user_id] && params[:start_date] && params[:end_date] && params[:guests]
      @start = Date.new params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i
      @ending = Date.new params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i
      current_user
      @group_size = params[:guests].to_i
      if @start >= Date.today && @start < @ending && @group_size > 0
        @rooms = Room.available_rooms(@start, @ending, @group_size)
      elsif @group_size > 0
        flash[:alert] = "Check-in and check-out dates must be in the future."
        redirect_to user_path(@user)
      elsif @start >= Date.today && @start < @ending
        flash[:alert] = "Please enter the number of guests (1, 2, etc.)."
        redirect_to user_path(@user)
      else
        flash[:alert] = "Check-in and check-out dates must be in the future, and the number of guests must be entered (1, 2, etc.)."
        redirect_to user_path(@user)
      end
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find_by_id(params[:id])
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :cost, :capacity, :image)
  end

end
