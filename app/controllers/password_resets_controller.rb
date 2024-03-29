class PasswordResetsController < ApplicationController
  before_action :_get_user,   only: [:edit, :update]
  before_action :_valid_user, only: [:edit, :update]
  before_action :_check_expiration, only: [:edit, :update] 

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワードリセット用のEmailを送信しました！"
      redirect_to root_url
    else
      flash.now[:danger] = "Emailアドレスが登録されていません"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(_user_params)
      login @user
      flash[:success] = "パスワードがリセットされました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def _user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def _get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def _valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
  
    # トークンが期限切れかどうか確認する
    def _check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "リンクの有効期限が切れています"
        redirect_to new_password_reset_url
      end
    end
end