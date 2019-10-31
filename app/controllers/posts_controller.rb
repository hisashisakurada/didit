class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージの投稿に成功しました'
      redirect_to root_path
    else
      @posts = current_user.feed_posts.page(params[:page])
      flash.now[:danger] = 'failed to post'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:menu, :weight, :counts, :set, :comment)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
