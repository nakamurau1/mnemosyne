class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【お知らせ】メールアドレス承認のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【お知らせ】パスワードの再設定用URL" 
  end

  def review_notice(user, review_items_count)
    @review_items_count = review_items_count
    mail to: user.email, subject: "【お知らせ】復習が必要な項目があります"
  end

  def user_registered(guest: false)
    @guest = guest
    mail to: "fyuichi@gmail.com", subject: "【暗記くん】ゲストログインされました"
  end
end