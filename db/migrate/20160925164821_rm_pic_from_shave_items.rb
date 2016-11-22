class RmPicFromShaveItems < ActiveRecord::Migration
  def change
    remove_attachment :shaving_items, :equipment_picture
  end
end
