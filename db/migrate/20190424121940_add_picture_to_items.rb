class AddPictureToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :front_picture, :string
    add_column :items, :back_picture, :string
  end
end
