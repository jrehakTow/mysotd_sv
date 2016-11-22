class CreateShavingItems < ActiveRecord::Migration
  def change
    create_table :shaving_items do |t|

      t.timestamps null: false
    end
  end
end
