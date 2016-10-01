class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :owned_post, only: [:edit, :update, :destroy]  

	def index
		@posts = Post.all
	end


	def new
		@post = current_user.posts.build
	end


	def create
		 @post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created Successfully"
			redirect_to posts_path
		else
			flash.now[:alert] = "Couldn't create post at this time"
			render 'new'
		end	
	end


	def show
		
	end


	def edit
		

	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post updated"
			redirect_to(post_path(@post))
		else
			flash.now[:alert] = "Could not update check your data"
			render 'edit'
		end
	end

	def destroy
		
		@post.destroy
		redirect_to posts_path
	end


	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end
	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post  
  		unless current_user == @post.user
	    	flash[:alert] = "That post doesn't belong to you!"
	    	redirect_to root_path
  		end
	end 
end
