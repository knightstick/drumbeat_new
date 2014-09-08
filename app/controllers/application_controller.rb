class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :choose_layout
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def title_helper(title)
    if title.present? 
      "Drumbeat | #{title}"
    else
      "Drumbeat"
    end
  end
  
  helper_method :current_user, :title_helper
  
  
  private
  
    def choose_layout
      if current_user
        "logged_in"
      else
        "application"
      end
    end
  

  
   
end
