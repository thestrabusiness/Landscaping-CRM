json.array!(@clients) do |client|
  json.extract! client, :id, :first_name, :last_name, :billing_address, :job_address, :city, :state, :zip, :cut, :mulch, :bush, :spring, :fall, :snow
  json.url client_url(client, format: :json)
end
