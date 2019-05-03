require 'test_helper'

class DecksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @public_deck = @user.decks.where(public: true).first
    @private_deck = @user.decks.where(public: false).first
    @other_user = users(:archer)
  end

  test "デッキのオーナー以外は非公開デッキの詳細ページにアクセスできない" do
    # 未ログイン
    get deck_path(@private_deck.id)
    assert_redirected_to root_path
    # デッキのオーナー以外
    log_in_as(@other_user)
    get deck_path(@private_deck.id)
    assert_redirected_to root_path
  end

  test "デッキのオーナーは非公開デッキの詳細ページにアクセスできる" do
    log_in_as(@user)
    get deck_path(@private_deck.id)
    assert_response :success
  end

  test "デッキのオーナー以外でも公開デッキの詳細ページにはアクセスできる" do
    # 未ログイン
    get deck_path(@public_deck.id)
    assert_response :success
    # デッキのオーナー以外
    log_in_as(@other_user)
    get deck_path(@public_deck.id)
    assert_response :success
  end
end
