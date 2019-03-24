class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【お知らせ】メールアドレス承認のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【お知らせ】パスワードの再設定用URL" 
  end
end