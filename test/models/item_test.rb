require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @item = @user.items.create
  end

  # review
  test "学習ステップのテスト" do
    assert @item.next_review_datetime < @item.created_at + 1.minute
    # 学習ステップ１の全パターン
    @item.review(:again)
    assert @item.next_review_datetime < 1.minute.after
    assert @item.learning_step == 1
    @item.review(:good)
    assert @item.next_review_datetime.between?(9.minutes.after, 10.minutes.after)
    assert @item.learning_step == 2
    @item.review(:again)
    assert @item.learning_step == 1
    @item.review(:easy)
    assert 4.days.after.all_day.cover?(@item.next_review_datetime)
    assert @item.learning_step == 3
    # 学習ステップ２の全パターン
    @item.review(:again)
    @item.review(:good)
    @item.review(:good)
    assert 1.days.after.all_day.cover?(@item.next_review_datetime)
    assert @item.learning_step == 3
    @item.review(:again)
    @item.review(:easy)
    assert 4.days.after.all_day.cover?(@item.next_review_datetime)
    assert @item.learning_step == 3
  end

  test "復習カードのテスト" do
    @item.review(:good)
    @item.review(:good)
    assert @item.learning_step == 3
    Timecop.travel(2.days.after)
    @item.review(:good)
    assert 5.days.after.all_day.cover?(@item.next_review_datetime)
    Timecop.travel(5.days.after)
    @item.review(:good)
    assert 13.days.after.all_day.cover?(@item.next_review_datetime)
    Timecop.travel(13.days.after)
    @item.review(:easy)
    assert 34.days.after.all_day.cover?(@item.next_review_datetime)
    Timecop.travel(34.days.after)
    @item.review(:again)
    assert @item.next_review_datetime < 1.minute.after
    Timecop.return
  end
end
