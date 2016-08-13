class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :client
  has_many :client_prices, through: :clients
  has_many :services, through: :clients
end
