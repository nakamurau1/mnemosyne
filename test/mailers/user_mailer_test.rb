require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
 test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "【お知らせ】メールアドレス承認のお願い", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end 

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "【お知らせ】パスワードの再設定用URL", mail.subject
    assert_equal ["noreply@example.com"], mail.from
  end
end
