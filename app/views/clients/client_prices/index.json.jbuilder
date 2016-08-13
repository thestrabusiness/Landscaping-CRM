json.array!(@client_prices) do |client_price|
  json.extract! client_price, :id, :price, :clients_id, :services_id
  json.url client_price_url(client_price, format: :json)
end
