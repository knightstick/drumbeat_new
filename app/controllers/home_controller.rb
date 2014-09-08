class HomeController < ApplicationController
  def index
    @user = current_user
    if @user 
      render action: "../users/show"
    else
      render "index"
    end
  end
end
