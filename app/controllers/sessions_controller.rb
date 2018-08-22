class SessionsController < ApplicationController

  def new
    @guest = Guest.new
  end

  def create
    #Signing in creates a new user with blank fields and directs to the new user's show page
    @guest = Guest.find_by(email: params[:guest][:email])
    if @guest && @guest.authenticate(params[:guest][:password])
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
