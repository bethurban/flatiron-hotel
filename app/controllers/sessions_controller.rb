class SessionsController < ApplicationController

  def new
    if session[:user_id]
      current_user
      redirect_to user_path(@user)
    end
  end

  def create
    if session[:user_id]
      current_user
      redirect_to user_path(@user)
    elsif params[:code]
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.phone_number = "111-111-1111"
        u.password = " "
        u.password_confirmation = " "
      end

      session[:user_id] = @user.id

      redirect_to user_path(@user)
    else
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to signin_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
