json.array!(@estimate_items) do |estimate_item|
  json.extract! estimate_item, :id, :estimate_id, :name, :price, :quantity
  json.url estimate_item_url(estimate_item, format: :json)
end
