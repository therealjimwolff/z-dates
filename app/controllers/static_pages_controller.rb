class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 15)
    end
  end

  def about
  end

  def contact
  end
end
