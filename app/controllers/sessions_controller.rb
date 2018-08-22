class SessionsController < ApplicationController

  def new
  end

  def create
    @guest = Guest.find_by(email: params[:email])
    if @guest && @guest.authenticate(params[:password])
      session[:user_id] = @guest.id
      redirect_to guest_path(@guest)
    else
      redirect_to signin_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

end
