class AddPicColumnsToShavingRecords < ActiveRecord::Migration
  def change
    add_attachment :shaving_records, :picture
  end
end
