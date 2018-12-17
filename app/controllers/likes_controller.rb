class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = "Post liked."
    redirect_to request.referrer
  end

  def destroy
    post = Post.find(params[:id])
    current_user.unlike(post)
    flash[:info] = "Post unliked."
    redirect_to request.referrer
  end
end
