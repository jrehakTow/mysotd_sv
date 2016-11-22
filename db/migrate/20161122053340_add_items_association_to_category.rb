class AddItemsAssociationToCategory < ActiveRecord::Migration
  def change
    add_reference :items, :category,  index: true
    add_foreign_key :items, :categories
  end
end
