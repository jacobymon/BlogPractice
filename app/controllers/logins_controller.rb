class LoginsController < ApplicationController
  def new
    #so that the view form can have the correct model
    @user = User.new 
    #notice the change between this part and dashboard's
    user = User.find_by(id: session[:user_id])
    redirect_to dashboards_path if user
  end

  def create
    @user = User.find_by(login_params)
    session[:user_id] = @user.id
    if @user
      redirect_to dashboards_path
    else
      flash[:alert] = "Email or password is wrong"
      render :new, status: :unprocessable_entity
    end
  end

  private
    def login_params
      params.require(:user).permit(:email, :password)
    end
  
end
