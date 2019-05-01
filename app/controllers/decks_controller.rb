class DecksController < ApplicationController
  before_action :_logged_in_user, only: [:index, :new]

  def index

  end

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(_deck_params)
    if @deck.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def _deck_params
      params.require(:deck).permit(:title, :description, :public)
    end
end
