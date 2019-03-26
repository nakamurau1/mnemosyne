class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :front_text
      t.text :back_text

      t.timestamps
    end
  end
end
