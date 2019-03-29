class ItemsController < ApplicationController
  before_action :_logged_in_user, only: [:index, :show, :new, :create, :edit]

  def index
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(_item_params)
      flash[:success] = "更新されました！"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def new
    @item = Item.find(params[:id])
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

end
