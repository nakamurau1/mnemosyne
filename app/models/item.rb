class Item < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

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
    if learning_step == 1
      case quality
        when :easy
          self.learning_step = 3
          return 4.days.after
        when :good
          self.learning_step = 2
          return 10.minutes.after
        when :again
          return 1.minute.after
      end
    elsif learning_step == 2
      case quality
        when :easy
          self.learning_step = 3
          return 4.days.after
        when :good
          self.learning_step = 3
          return 2.day.after
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
        @new_easiness_factor = self.easiness_factor
        return Time.zone.today
    end
    interval = _calc_interval(Time.zone.today, self.previous_review_datetime)
    Time.zone.today + (interval * @new_easiness_factor)
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

  def _calc_interval(today, previous_review_datetime)
    today - previous_review_datetime
  end
end
