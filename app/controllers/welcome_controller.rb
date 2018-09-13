class WelcomeController < ApplicationController

  def home
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      redirect_to user_path(@user)
    end
  end

end
