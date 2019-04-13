class Item < ApplicationRecord
  after_initialize :_set_default_value
  belongs_to :user
  validates :user_id, presence: true

  GRADE = {
      easy: 5,
      good: 4
  }

  def review(quality)
    self.review_count += 1
    self.next_review_date = calc_next_review_date(quality.to_sym, self.previous_review_date)
    self.previous_review_date = Time.zone.today
    self.easiness_factor = @new_easiness_factor
    save
  end

  def calc_next_review_date(quality, previous_review_date)
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
    interval = _calc_interval(Time.zone.today, previous_review_date)
    Time.zone.today + (interval * @new_easiness_factor)
  end

  private

    def _set_default_value
      self.next_review_date = Time.zone.today
    end

    def _calc_easiness_factor(current_value, quality)
      grade = GRADE[quality]
      new_value = current_value + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02))
      if new_value < 1.3
        1.3
      else
        new_value
      end
    end

  def _calc_interval(today, previous_review_date)
    today - previous_review_date
  end
end
