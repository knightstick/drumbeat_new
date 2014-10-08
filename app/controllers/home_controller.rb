class HomeController < ApplicationController
  def index
    if current_user 
      redirect_to "/me"
    else
      render "index"
    end
  end
end
