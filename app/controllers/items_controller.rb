class ItemsController < ApplicationController
  before_action :_logged_in_user, only: [:index, :show, :new, :create, :edit, :review]

  def index
    @items = current_user.items.paginate(page: params[:page])
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
    @item = current_user.items.build
    if params[:deck_id].present?
      @item.deck_id = params[:deck_id]
    end
  end

  def create
    @item = current_user.items.build(_item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to root_path
  end

  def review
    quality = params[:quality]
    @item = Item.find(params[:item_id])
    @item.review(quality)
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

private

    def _item_params
      params.require(:item).permit(:front_text, :back_text, :front_picture, :back_picture, :deck_id)
    end

end
