class Item < ApplicationRecord
  after_initialize :set_default_value, if: :new_record?
  belongs_to :user
  belongs_to :deck, optional: true
  validates :user_id, presence: true
  validate  :_picture_size
  mount_uploader :front_picture, PictureUploader
  mount_uploader :back_picture, PictureUploader
  default_scope { order(id: :desc) }

  GRADE = {
      easy: 5,
      good: 4
  }

  def review(quality)
    self.next_review_datetime = calc_next_review_datetime(quality.to_sym)
    self.previous_review_datetime = Time.zone.now
    self.easiness_factor = @new_easiness_factor
    self.review_count += 1
    save
  end

  def calc_next_review_datetime(quality)
    @new_easiness_factor = self.easiness_factor
    if learning_step == 1
      case quality
        when :easy
          self.learning_step = 3
          return 4.days.after
        when :good
          self.learning_step = 2
          return 10.minutes.after
        when :again
          self.learning_step = 1
          return 1.minute.after
      end
    elsif learning_step == 2
      case quality
        when :easy
          self.learning_step = 3
          return 3.days.after
        when :good
          self.learning_step = 3
          return 1.day.after
        when :again
          self.learning_step = 1
          return 1.minutes.after
      end
    end

    case quality
      when :easy
        @new_easiness_factor = _calc_easiness_factor(self.easiness_factor, quality)
      when :good
        # easiness_factor は更新しない
        @new_easiness_factor = self.easiness_factor
      when :again
        self.learning_step = 1
        @new_easiness_factor = self.easiness_factor
        return Time.zone.today
    end
    interval = (Time.zone.today - self.previous_review_datetime.to_s.to_date).to_i
    Time.zone.today + (interval * @new_easiness_factor).ceil
  end

  # 日付まで表示する
  def next_review_timing_str
    self.next_review_datetime&.strftime("%Y/%m/%d")
  end

  def set_default_value
    self.easiness_factor          = 2.5
    self.next_review_datetime     = Time.zone.now
    self.review_count             = 0
    self.previous_review_datetime = nil
    self.learning_step            = 1
  end

  private

    def _calc_easiness_factor(current_value, quality)
      grade = GRADE[quality]
      new_value = current_value + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02))
      if new_value < 1.3
        1.3
      else
        new_value
      end
    end

    # アップロードされた画像のサイズをバリデーションする
    def _picture_size
      if front_picture.size > 5.megabytes && back_picture.size > 5.megabytes
        errors.add(:picture, "5MB以下のファイルを選択してください")
      end
    end
end
