class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントが有効化されていません。"
        message += "アカウント有効化のEmailを受信しているか確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end 
    else
      flash.now[:danger] = 'パスワードが違います'
      render 'new'
    end
  end

  def guest_login
    if cookies[:remember_token].blank?
      user = User.create(name: "ゲストユーザー#{Time.zone.now.strftime("%Y%m%d%H%m%s")}")
      remember(user)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
