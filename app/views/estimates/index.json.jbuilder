json.array!(@estimates) do |estimate|
  json.extract! estimate, :id, :date, :total, :notes, :client_id
  json.url estimate_url(estimate, format: :json)
end
