json.array!(@recurring_prices) do |recurring_price|
  json.extract! recurring_price, :id, :price, :clients_id, :recurring_services_id
  json.url recurring_price_url(recurring_price, format: :json)
end
