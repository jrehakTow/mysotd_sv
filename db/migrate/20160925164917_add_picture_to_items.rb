class AddPictureToItems < ActiveRecord::Migration
  def change
    add_attachment :items, :equipment_picture
  end
end
