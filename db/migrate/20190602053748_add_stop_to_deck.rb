class AddStopToDeck < ActiveRecord::Migration[5.1]
  def change
    add_column :decks, :stop, :boolean
  end
end
