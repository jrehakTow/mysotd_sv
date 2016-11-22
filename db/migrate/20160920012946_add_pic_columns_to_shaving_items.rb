class AddPicColumnsToShavingItems < ActiveRecord::Migration
  def change
    add_attachment :shaving_items, :equipment_picture
  end
end
