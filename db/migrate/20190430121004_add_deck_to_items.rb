class AddDeckToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :deck, foreign_key: true
  end
end
