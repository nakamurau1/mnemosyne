class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(_item_params)
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
