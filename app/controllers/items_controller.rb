class ItemsController < ApplicationController
  before_action :_logged_in_user, only: [:index, :show, :new, :create]

  def index
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(_item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def _item_params
      params.require(:item).permit(:front_text, :back_text)
    end

    def _logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
