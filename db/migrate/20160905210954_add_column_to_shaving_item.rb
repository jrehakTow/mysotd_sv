class AddColumnToShavingItem < ActiveRecord::Migration
  def change
    add_column :shaving_items, :item_id, :integer
    add_column :shaving_items, :shaving_record_id, :integer
  end
end
