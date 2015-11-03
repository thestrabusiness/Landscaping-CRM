class Service < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :client
  has_many :reccuring_prices, through: :clients
  has_many :recurring_services, through: :clients
end
