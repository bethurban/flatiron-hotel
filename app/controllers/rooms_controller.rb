class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_path(@room)
    else
      redirect_to new_room_path
    end
  end

  def index
    if session[:user_id] && params[:start_date] && params[:end_date] && params[:guests]
      @start = Date.new params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i
      @ending = Date.new params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i
      @user = User.find_by_id(session[:user_id])
      if @start >= Date.today && @start < @ending
        @group_size = params[:guests].to_i
        @rooms = Room.available_rooms(@start, @ending, @group_size)
      else
        flash[:alert] = "Check-in and check-out dates must be in the future."
        redirect_to user_path(@user)
      end
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_img = "room_#{@room.room_number}.jpg"
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :cost, :capacity)
  end

end
