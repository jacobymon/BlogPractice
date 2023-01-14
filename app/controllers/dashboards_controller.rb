class DashboardsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    redirect_to new_login_path unless user
    @blog = Blog.all
  end

  def edit
    session[:blog_id] = params[:id]
    @test = session[:blog_id]
    @blog = Blog.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @blog.user_id != @user.id
      flash[:alert] = "You are not the author of that blog"
      redirect_to dashboards_path
    end

      
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

    puts " ++++++++++++++++++++++++ #{session[:blog_id]}"

    if @blog.save     
      redirect_to dashboard_path(@blog)
    else
      flash[:alert] = "couldn't create blog"
      render :new, status: :unprocessable_entity
    end
  
  end  

  def update
    @id = params[:id]
    @user = User.find_by(id: session[:user_id])
    @blog = Blog.find_by(id: session[:blog_id])
    puts "****************** #{session[:blog_id]}"
    if @blog.update(params.require(:blog).permit(:title, :blog))
      flash[:alert] = "Blog updated succesfully"
      redirect_to dashboards_path
    else
      flash[:alert] = "Blog not updated succesfully"
      render :edit, status: :unprocessable_entity

    end
  end

  private
    def dash_params
      params.require(:blog).permit(:title, :blog)
    end
end
