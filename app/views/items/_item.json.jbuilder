json.extract! item, :id, :name, :description, :uses, :price, :purchase_date, :retired, :user_id, :created_at, :updated_at
json.url item_url(item, format: :json)