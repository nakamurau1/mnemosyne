class UsersController < ApplicationController
  before_action :_logged_in_user, only: [:edit, :update, :destroy]
  before_action :_correct_user, only: [:edit, :update]
  before_action :_admin_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if current_user.present?
      @user = current_user
      @user.assign_attributes(_user_params)
      @user.create_activation_digest
    else
      @user = User.new(_user_params)
    end
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      UserMailer.user_registered.deliver_now
      flash[:info] = "アカウント有効化メールを確認してください"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update 
    @user = User.find_by(id: params[:id])
    user_params = _user_params.except(:email)
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "ユーザーが削除されました"
    redirect_to root_path
  end

  private

  def _user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :notice)
  end

  def _correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless (current_user?(@user) && !@user.guest?)
  end

  def _admin_user
    redirect_to root_path unless current_user.admin?
  end
end
