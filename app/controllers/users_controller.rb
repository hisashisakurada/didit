class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :likes, :index, :destroy]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    @favposts = @user.favposts.order(id: :desc).page(params[:page])
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
      flash[:success] = 'ユーザ登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
 
end
