class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @mode = :review
      @items = current_user.review_items.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end

  def contact
  end
end
