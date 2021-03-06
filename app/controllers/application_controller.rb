class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def title_helper(title)
    if title.present? 
      "Drumbeat | #{title}"
    else
      "Drumbeat"
    end
  end

  def score_helper(score)
    if score == 4
      "4 bars"
    elsif score == 60
      "60 secs"
    elsif score == 5
      "5 mins"
    else
      score
    end
  end
  
  def login_required
    if current_user.blank?
      flash[:notice] = "You must be logged in to view this page."
      redirect_to('/') 
    end
  end
  
  helper_method :current_user, :title_helper, :score_helper
end
