json.array!(@services) do |service|
  json.extract! service, :id, :name, :category, :quantity, :invoice_id
  json.url service_url(service, format: :json)
end
