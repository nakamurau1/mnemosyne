class DecksController < ApplicationController
  before_action :_logged_in_user, only: [:index, :new, :create, :edit, :copy]

  def index
    @decks = current_user.decks.paginate(page: params[:page])
  end

  def public_index
    @decks = Deck.where(public: true).paginate(page: params[:page])
  end

  def show
    @deck = Deck.where(id: params[:id]).first
    if !current_user?(@deck.user) && !@deck.public?
      redirect_to root_path
    end
    @items = @deck.items.paginate(page: params[:page])
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

  def edit
    @deck = Deck.find_by(id: params[:id])
  end

  def copy

  end

  private

    def _deck_params
      params.require(:deck).permit(:title, :description, :public)
    end
end
