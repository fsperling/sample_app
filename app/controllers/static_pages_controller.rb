class StaticPagesController < ApplicationController
  def home
    @games = Game.paginate(page: params[:page], :per_page => 10 )
  end
  
  def home2
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end    
  end

  def help
  end

  def about
  end

  def contact
  end
end
