json.array!(@recurring_services) do |recurring_service|
  json.extract! recurring_service, :id, :name
  json.url recurring_service_url(recurring_service, format: :json)
end
