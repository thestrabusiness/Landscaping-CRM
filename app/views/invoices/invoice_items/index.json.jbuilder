json.array!(@invoice_item) do |item|
  json.extract! item, :id, :name, :category, :quantity, :invoice_id
  json.url invoice_item_url(item, format: :json)
end
