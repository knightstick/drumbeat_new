class HomeController < ApplicationController
  def index
    @user = current_user
    if @user 
      redirect_to "/profile"
    else
      render "index"
    end
  end
end
