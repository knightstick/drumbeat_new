class HomeController < ApplicationController
  def index
    @user = current_user
    if @user 
      redirect_to profile_path
    else
      render "index"
    end
  end
end
