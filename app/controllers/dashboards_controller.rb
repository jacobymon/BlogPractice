class DashboardsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    redirect_to new_login_path unless user
    @blog = Blog.all
  end

  def edit
    @blog = Blog.find_by(params[:id])
  
  end

  def post
  end

  def show
    @user = User.find_by(id: session[:user_id])
    @blog = @user.blogs
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(dash_params)
    @user = User.find_by(id: session[:user_id])
    @blog.user = @user
    if @blog.save     
      redirect_to dashboard_path(@blog)
    else
      flash[:alert] = "couldn't create blog"
      render :new, status: :unprocessable_entity
    end
  
  end  

  def update
    @blog = Blog.find_by(params[:id])

    if @blog.update(params.require(:blog).permit(:title, :blog))
      flash[:notice] = "blog was updated successfully"
      redirect_to dashboards_path
      else
          render :index, status: unprocessable_entity
      end
    end

  private
    def dash_params
      params.require(:blog).permit(:title, :blog)
    end
end
