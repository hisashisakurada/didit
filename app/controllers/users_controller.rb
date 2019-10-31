class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :likes]

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User Registered'
      redirect_to @user
    else
      flash[:danger] = 'User registration failed'
      render :new
    end
  end

  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
 
end
