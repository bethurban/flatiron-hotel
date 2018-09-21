class WelcomeController < ApplicationController

  def home
    if session[:user_id]
      current_user
      redirect_to user_path(@user)
    end
  end

end
