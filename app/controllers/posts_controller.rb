class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created.'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    flash[:info] = "Post deleted."
    redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
