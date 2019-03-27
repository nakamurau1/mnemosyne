class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :front_text
      t.text :back_text
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
