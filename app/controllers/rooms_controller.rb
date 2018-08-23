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
    @rooms = Room.all
    @user = User.find_by_id(session[:user_id])
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
