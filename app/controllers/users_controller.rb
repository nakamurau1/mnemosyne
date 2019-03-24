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
    @user = User.new(_user_params)    # 実装は終わっていないことに注意!
    if @user.save
      # 保存の成功をここで扱う。
      flash[:success] = "Welcome to the Sample App!"
      login @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update 
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(_user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  private

  def _user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def _logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def _correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless current_user?(@user) 
  end

  def _admin_user
    redirect_to root_path unless current_user.admin?
  end
end
