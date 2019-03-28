class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @items = current_user.items.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end

  def contact
  end
end
