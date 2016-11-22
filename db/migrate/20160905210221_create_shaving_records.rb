class CreateShavingRecords < ActiveRecord::Migration
  def change
    create_table :shaving_records do |t|
      t.text :description
      t.datetime :date
      t.integer :rating
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
