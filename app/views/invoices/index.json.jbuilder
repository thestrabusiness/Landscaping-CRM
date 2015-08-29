json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :date, :performed_by, :status, :note, :client_id
  json.url invoice_url(invoice, format: :json)
end
