json.extract! shaving_record, :id, :description, :date, :rating, :user_id, :created_at, :updated_at
json.url shaving_record_url(shaving_record, format: :json)