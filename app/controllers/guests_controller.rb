class GuestsController < ApplicationController

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      session[:user_id] = @guest.id
      redirect_to guest_path(@guest)
    else
      redirect_to new_guest_path
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email, :phone_number, :password)
  end

end
