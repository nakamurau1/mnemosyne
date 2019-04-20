require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "暗記くん"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "TOP | #{@base_title}"
  end

  test "should get help" do
    get help_path 
    assert_response :success
    assert_select "title", "ヘルプ | #{@base_title}"
  end

  test "should get about" do
    get about_path 
    assert_response :success
    assert_select "title", "本サービスについて | #{@base_title}"
  end
end
