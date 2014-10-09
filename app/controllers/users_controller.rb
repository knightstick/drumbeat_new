class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  before_action :current_user
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user created!"
      session[:user_id] = @user.id
      redirect_to "/me"
    else
      flash[:error] = "ERROR"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def profile
    @user = current_user
  end

  def practice
    @user = current_user
    @scorecards = @user.current_scorecards
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
