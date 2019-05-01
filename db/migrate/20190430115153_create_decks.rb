class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.references :user, foreign_key: true
      t.text :title
      t.text :description
      t.boolean :public

      t.timestamps
    end
  end
end
