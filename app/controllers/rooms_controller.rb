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
      @ending = ending = Date.new params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i
      @group_size = params[:guests].to_i
      @rooms = Room.available_rooms(@start, @ending, @group_size)
      @user = User.find_by_id(session[:user_id])
    elsif session[:user_id]
      @rooms = Room.all
      @user = User.find_by_id(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def show
    @room = Room.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :cost, :capacity)
  end

end
