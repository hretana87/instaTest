class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => :index

  def new
  	@post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create

    @user = current_user
    @post = @user.posts.create(permit_post)

  	if @post.save
  		flash[:success] = "Success!"
  		redirect_to post_path(@post)
  	else 
  		flash[:error] = @post.errors.full_messages
  		redirect_to new_post_path
  	end
  end

  private
  	def permit_post
  		params.require(:post).permit(:image, :description, :user_id)
  	end
end
