class AddReviewFieldsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :easiness_factor, :float, default: 2.5
    add_column :items, :next_review_datetime, :datetime
    add_column :items, :previous_review_datetime, :datetime
    add_column :items, :review_count, :integer, default: 0
    add_column :items, :learning_step, :integer, default: 1
  end
end
