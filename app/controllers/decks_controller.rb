class DecksController < ApplicationController
  before_action :_logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy, :copy, :stop, :resume]
  before_action :_correct_user, only: [:edit, :update, :destroy, :stop, :resume]

  def index
    @decks = current_user.decks.paginate(page: params[:page])
  end

  def public_index
    @decks = Deck.where(public: true).paginate(page: params[:page])
  end

  def show
    @deck = Deck.find(params[:id])
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

  def update
    @deck = Deck.find_by(id: params[:id])
    if @deck.update_attributes(_deck_params)
      flash[:success] = "デッキを更新しました！"
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    Deck.find(params[:id]).destroy
    redirect_to decks_path
  end

  def copy
    @deck = Deck.find(params[:id])
    if @deck.copy_to(current_user)
      flash[:success] = "あなたのデッキにコピーしました！学習を始めましょう！"
    else
      flash[:danger] = "コピーできませんでした"
    end
    redirect_to @deck
  end

  def stop
    @deck = Deck.find(params[:id])
    return if @deck.nil? || @deck.stop?
    @deck.stop_learning
  ensure
    return redirect_to @deck
  end

  def resume
    @deck = Deck.find(params[:id])
    return if @deck.nil? || !@deck.stop?
    @deck.resume_learning
  ensure
    return redirect_to @deck
  end

  private

    def _deck_params
      params.require(:deck).permit(:title, :description, :public)
    end

    def _correct_user
      @deck = Deck.find(params[:id])
      redirect_to root_path unless current_user?(@deck.user)
    end
end
