class Service < ActiveRecord::Base
  has_many :client_prices #, dependent: :destroy
  has_many :clients, through: :client_prices
end
