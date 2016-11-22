class RenameColumnPurchaseDateInItemsToPurchaseDate < ActiveRecord::Migration
  def change
    rename_column  :items, :purchaseDate, :purchase_date
  end
end
