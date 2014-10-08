class HomeController < ApplicationController
  def index
    @user = current_user
    if @user 
      redirect_to "/me"
    else
      render "index"
    end
  end
end
