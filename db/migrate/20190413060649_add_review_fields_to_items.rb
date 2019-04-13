class AddReviewFieldsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :easiness_factor, :float
    add_column :items, :next_review_date, :date
    add_column :items, :previous_review_date, :date
    add_column :items, :review_count, :integer
  end
end
