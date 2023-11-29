class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post=Post.find_by(id:params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @replys = Reply.all.order(created_at: :desc)
    @reply = Reply.where(post_id: @post.id)
    @Post_reply = @reply.pluck(:user_id)
    @post_repliers = User.where(id: @Post_reply)
  end

  def new
    @post=Post.new
  end

  def create
    require 'mini_magick'
    @post = Post.new(content: params[:content],user_id: @current_user.id)
     if @post.save
      if params[:image]
        @post.post_image = "#{@post.id}post_image.jpg"
        image = MiniMagick::Image.read(params[:image])
        image.resize "450x300"
        image.write "public/post_images/#{@post.post_image}"
        @post_last = Post.last
        @post_last.post_image = "#{@post_last.id}post_image.jpg"
        @post_last.save
      end
      flash[:notice]="投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new",status: :unprocessable_entity)
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
     if @post.save
      flash[:notice]="投稿を編集しました"
      redirect_to("/posts/index")
     else
      render("posts/edit",status: :unprocessable_entity)
     end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
   if @post.user_id != @current_user.id
     flash[:notice] = "権限がありません"
     redirect_to("/posts/index")
    end  
  end

  def reply
    @post=Post.find_by(id:params[:id])
    @replys = Reply.all.order(created_at: :desc)
  end

  def Rcreate
    @post = Post.find_by(id: params[:id])
    @reply = Reply.new(user_id: @current_user.id, post_id: params[:id],reply: params[:reply])
    @reply.save
    redirect_to("/posts/index")
  end
end
